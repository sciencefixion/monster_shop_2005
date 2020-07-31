require 'rails_helper'

RSpec.describe "Admin can see a merchants dashboard" do
  before :each do
    @admin_user = create(:user , email: 'admin@test1.com',  role: 2 )
    @default_user = create(:user)

    @merchant_1 = create(:merchant)

    @item_2 = create(:item, merchant: @merchant_1)
    @item_4 = create(:item, merchant: @merchant_1)
    @item_8 = create(:item, merchant: @merchant_1)

    @order_1 = create(:order , user: @default_user, status: 1)
    @order_2 = create(:order , user: @default_user)

    visit '/login'

    within  "form" do
        fill_in :email,	with: "admin@test1.com"
        fill_in :password,	with: "123456"
        click_on 'Login'
    end
  end

    it "can see merchants dashboard" do

      visit "/admin/merchants"
      click_on "#{@merchant_1.name}"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}")
    end
  end
