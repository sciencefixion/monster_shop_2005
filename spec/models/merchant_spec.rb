require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :items}
  end

  describe 'instance methods' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    end
    it 'no_orders' do
      bert = User.create(name: "Bert", address: "123 Sesame St.", city: "NYC", state: "New York", zip: "10001", email: "bert@test.com", password: "123456")
      expect(@meg.no_orders?).to eq(true)

      order_1 = bert.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      item_order_1 = order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

      expect(@meg.no_orders?).to eq(false)
    end

    it 'item_count' do
      chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 30, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)

      expect(@meg.item_count).to eq(2)
    end

    it 'average_item_price' do
      chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)

      expect(@meg.average_item_price).to eq(70)
    end

    it 'distinct_cities' do
      chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
      bert = User.create(name: "Bert", address: "123 Sesame St.", city: "NYC", state: "New York", zip: "10001", email: "bert@test.com", password: "123456")

      order_1 = bert.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order_2 = bert.orders.create!(name: 'Brian', address: '123 Brian Ave', city: 'Denver', state: 'CO', zip: 17033)
      order_3 = bert.orders.create!(name: 'Dao', address: '123 Mike Ave', city: 'Denver', state: 'CO', zip: 17033)
      order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      order_2.item_orders.create!(item: chain, price: chain.price, quantity: 2)
      order_3.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

      expect(@meg.distinct_cities).to include("Denver")
      expect(@meg.distinct_cities).to include("Hershey")
    end

    xit 'pending_orders' do
      @merchant = create(:merchant)

      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)

      @merchant_user  = create(:user, merchant: @merchant, email: 'merchant@test.com',  role: 1)
      @default_user_1 = create(:user)
      @default_user_2 = create(:user)

      @order_1 = create(:order, user: @default_user_1, status: 1)
      @order_2 = create(:order, user: @default_user_1)
      @order_3 = create(:order, user: @default_user_2)

      @item_order_1 = create(:item_order, item: @item_1, order: @order_1)
      @item_order_2 = create(:item_order, item: @item_1, order: @order_2)
      @item_order_3 = create(:item_order, item: @item_2, order: @order_2)
      @item_order_4 = create(:item_order, item: @item_2, order: @order_3)

      expect(@merchant.pending_orders).to have_content(@order_2.id)
      expect(@merchant.pending_orders).to have_content(@order_3.id)
      expect(@merchant.pending_orders).to_not have_content(@order_1.id)
    end
  end
end
