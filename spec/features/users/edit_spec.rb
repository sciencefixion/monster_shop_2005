require 'rails_helper'

RSpec.describe "User can edit their profile data" do
  describe "As a registered user" do
    before :each do
      @jim = User.create(name: "Jim", address: "3455 LKV Rd.", city: "Denver", state: "CO", email: "test@test.com", zip: "80124", password: "123456")
      visit '/login'
      fill_in :email,	with: "test@test.com"
      fill_in :password,	with: "123456"
      click_button "Login"
    end

    it "can edit the users data" do
      visit "/profile"

      click_on "Edit Profile"

      expect(current_path).to eq("/profile/edit")

      fill_in :name,	with: "Jimmy"
      fill_in :address,	with: "3455 LKV Rd."
      fill_in :city,	with: "Lakewood"
      fill_in :state,	with: "CO"
      fill_in :zip,	with: "80124"
      fill_in :email,	with: "test@test.com"

      click_button "Update"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Your profile has been updated")

      expect(page).to have_content("Name: Jimmy")
      expect(page).to have_content("Address: #{@jim.address}")
      expect(page).to have_content("Lakewood")
      expect(page).to have_content("State: #{@jim.state}")
      expect(page).to have_content("Zip: #{@jim.zip}")
    end
  end
end

# The form is prepopulated with all my current information except my password
# When I change any or all of that information
