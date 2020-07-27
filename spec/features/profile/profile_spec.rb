require 'rails_helper'

RSpec.describe 'User profile page' do
  before(:each) do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    @bert = User.create(name: "Bert", address: "123 Sesame St.", city: "NYC", state: "New York", zip: "10001", email: "bert@test.com", password: "123456")

    visit '/login'
    fill_in :email,	with: "bert@test.com"
    fill_in :password,	with: "123456"
    click_button "Login"

    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"

    visit "/cart"

    click_on "Checkout"

    fill_in :name, with: @bert.name
    fill_in :address, with: @bert.address
    fill_in :city, with: @bert.city
    fill_in :state, with: @bert.state
    fill_in :zip, with: @bert.zip

    click_button "Create Order"

    @new_order = Order.last
  end

  it "displays orders link" do

    visit "/profile"

    click_on "My Orders"

    expect(current_path).to eq("/profile/orders")
  end
end
