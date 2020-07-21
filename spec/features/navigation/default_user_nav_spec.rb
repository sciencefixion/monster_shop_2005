require "rails_helper"
# Story 3: As a default user
# I see the same links as a visitor
# Plus the following links
# - a link to my profile page ("/profile")
# - a link to log out ("/logout")
#
# Minus the following links
# - I do not see a link to log in or register
#
# I also see text that says "Logged in as Mike Dao" (or whatever my name is)

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
    end

    expect(page).to have_content("Logged in as Jim")
  end
end
