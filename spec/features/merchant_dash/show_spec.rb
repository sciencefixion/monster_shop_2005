require 'rails_helper'

RSpec.describe "Merchant dashboard show page" do
  before :each do
    @merchant = create(:merchant)

    @merchant_user = @merchant.creates(:user, email: 'merchant@test.com',  role: 1)
    @default_user  = creates(:user)

    @order_1 = create(:order, user: @default_user, status: 1)
    @order_2 = create(:order, user: @default_user)

    visit '/login'
    within  "form" do
      fill_in :email,	with: "merchant@test1.com"
      fill_in :password,	with: "123456"
      click_on 'Login'
    end

  end
  it "as a merchant employee" do
    visit "/merchant"
    expect(page).to have_content(@merchant_user.merchant.name)
    expect(page).to have_content(@merchant_user.merchant.address)
  end

end
