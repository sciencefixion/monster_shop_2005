require 'rails_helper'

RSpec.describe "User profile show page" do
  describe "As a registered user" do
    before :each do
      @jim = User.create(name: "Jim", address: "3455 LKV Rd.", city: "Denver", state: "CO", email: "test@test.com", zip: "80124", password: "123456")
      visit '/login'
      fill_in :email,	with: "test@test.com"
      fill_in :password,	with: "123456"
      click_button "Login"
    end

    it "has users attributes on the profile show page" do
      visit "/profile"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Name: #{@jim.name}")
      expect(page).to have_content("Address: #{@jim.address}")
      expect(page).to have_content("City: #{@jim.city}")
      expect(page).to have_content("State: #{@jim.state}")
      expect(page).to have_content("Zip: #{@jim.zip}")
      expect(page).to_not have_content(@jim.password)
      expect(page).to have_link("Edit Profile")
    end
  end
end
