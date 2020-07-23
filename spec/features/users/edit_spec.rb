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

      expect(page).to_not have_content("Password")

      click_button "Update"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Your profile has been updated")

      expect(page).to have_content("Name: Jimmy")
      expect(page).to have_content("Address: #{@jim.address}")
      expect(page).to have_content("Lakewood")
      expect(page).to have_content("State: #{@jim.state}")
      expect(page).to have_content("Zip: #{@jim.zip}")
    end

    it "Sad path for: can edit the users data. Not all fields are filled out" do
      visit "/profile"

      click_on "Edit Profile"

      expect(current_path).to eq("/profile/edit")

      fill_in :name,	with: "Jimmy"
      fill_in :address,	with: "3455 LKV Rd."
      fill_in :city,	with: ""
      fill_in :state,	with: "CO"
      fill_in :zip,	with: ""
      fill_in :email,	with: "test@test.com"

      click_button "Update"

      expect(page).to have_content("User could not be updated:")
      expect(current_path).to eq("/profile/edit")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("Zip can't be blank")

    end
  end
end
