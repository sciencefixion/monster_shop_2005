require "rails_helper"

RSpec.describe "User navigation" do
  it "shows profile and logout links and does not show login or register links" do
    user = User.create(name: "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456")

    visit "/merchants"

    click_link "Login"

    fill_in :email,	with: "test@test.com"
    fill_in :password,	with: "123456"
    click_button "Login"

    within 'nav' do
      expect(page).to have_link("Log Out")
      expect(page).to have_link("Profile")
      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Register")
      expect(page).to_not have_link("My Merchant Dashboard")
      expect(page).to_not have_link("My Admin Dashboard")
    end

    expect(page).to have_content("Logged in as Jim")
  end
end
