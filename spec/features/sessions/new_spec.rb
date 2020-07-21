require "rails_helper"

# User Story 13, User can Login
#
# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page

RSpec.describe "User session" do
  it "allows user to log in" do
    user = User.create(name: "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456")

    visit '/login'

    fill_in :email,	with: "test@test.com"
    fill_in :password,	with: "123456"
    click_button "Login"

    expect(current_path).to eq("/profile")
    
    expect(page).to have_content("You are now logged in.")

    # If I am a merchant user, I am redirected to my merchant dashboard page
    # If I am an admin user, I am redirected to my admin dashboard page
    # And I see a flash message that I am logged in
  end
end
