require 'rails_helper'

RSpec.describe "Merchant's items index page" do
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

  it "text" do
    visit '/mechant/dashboard'

    click_on 'My Items'

    expect(current_path).to eq('/merchant/items')
  end
end

# 
# [ ] done
#
#
#
# When I click that link
# My URI route should be "/merchant/items"
