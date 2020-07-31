require 'rails_helper'

RSpec.describe "Merchant navigation" do
  it "as a merchant employee, it displays same links as regurlar user PLUS a link to my merchant dashboard" do
    user = create(:user ,name: "Michael", email: "test1@test.com" , role: 1)

    visit '/merchants'

    click_link "Login"

    fill_in :email,	with: "test1@test.com"
    fill_in :password,	with: "123456"
    click_button "Login"

    within 'nav' do
      expect(page).to have_link("Log Out")
      expect(page).to have_link("My Merchant Dashboard")
      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Register")
    end
    expect(user.merchant?).to be_truthy
    expect(page).to have_content("Logged in as Michael")
  end
end



# As a merchant employee
# I see the same links as a regular user
# Plus the following links:
# - a link to my merchant dashboard ("/merchant")
