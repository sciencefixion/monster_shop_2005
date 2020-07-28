require 'rails_helper'

RSpec.describe "Merchant dashboard show page" do
  before :each do
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

    visit '/login'
    within  "form" do
      fill_in :email,	with: @merchant_user.email
      fill_in :password,	with: @merchant_user.password
      click_on 'Login'
    end
  end

  it "displays name and address the merchant works for" do

    visit "/merchant/dashboard"
    expect(page).to have_content(@merchant_user.merchant.name)
    expect(page).to have_content(@merchant_user.merchant.address)
    expect(page).to have_content(@merchant_user.merchant.city)
    expect(page).to have_content(@merchant_user.merchant.state)
    expect(page).to have_content(@merchant_user.merchant.zip)
  end

  it "Merchant dashboard displays orders" do

    visit "/merchant/dashboard"

    expect(page).to_not have_link(@order_1.id) #(/merchant/orders/15)
    expect(page).to_not have_content(@order_1.grandtotal)
    expect(page).to have_link(@order_2.id) #(/merchant/orders/15)
    expect(page).to have_content(@order_2.date_created)
    expect(page).to have_content(@order_2.total_quantity_of_items)
    expect(page).to have_content(@order_2.grandtotal)
    expect(page).to have_link(@order_3.id)
    expect(page).to have_content(@order_3.date_created)
    expect(page).to have_content(@order_3.total_quantity_of_items)
    expect(page).to have_content(@order_3.grandtotal)
    save_and_open_page
  end
end
