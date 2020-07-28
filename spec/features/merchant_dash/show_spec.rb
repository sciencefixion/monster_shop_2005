require 'rails_helper'

RSpec.describe "Merchant dashboard show page" do
  before :each do
    @merchant = create(:merchant)

    @merchant_user = create(:user, merchant: @merchant, email: 'merchant@test.com',  role: 1)
    @default_user  = create(:user)

    @order_1 = create(:order, user: @default_user, status: 1)
    @order_2 = create(:order, user: @default_user)

    visit '/login'
    within  "form" do
      fill_in :email,	with: "merchant@test.com"
      fill_in :password,	with: "123456"
      click_on 'Login'
    end

  end
  it "as a merchant employee" do
    visit "/merchant/dashboard"
    expect(page).to have_content(@merchant_user.merchant.name)
    expect(page).to have_content(@merchant_user.merchant.address)
    expect(page).to have_content(@merchant_user.merchant.city)
    expect(page).to have_content(@merchant_user.merchant.state)
    expect(page).to have_content(@merchant_user.merchant.zip)
    save_and_open_page
  end

end
