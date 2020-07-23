require "rails_helper"

RSpec.describe "unique email" do
    it "cannot update with already used email" do
        User.create(name: "Jim", address: "3455 LKV Rd.", city: "Denver", state: "CO", email: "jm@test.com", zip: "80124", password: "123456")
        User.create(name: "Michael", address: "3455 LKV Rd.", city: "Denver", state: "CO", email: "mk@test.com", zip: "80124", password: "123456")

        visit '/login'
        fill_in :email,	with: "jm@test.com"
        fill_in :password,	with: "123456"
        click_button "Login"


        visit "/profile/edit"
        fill_in :email,	with: "mk@test.com"

        click_button "Update"

        expect(current_path).to  eq("/profile/edit")
        expect(page).to  have_content("\"Email has already been taken\"")
    end
end

