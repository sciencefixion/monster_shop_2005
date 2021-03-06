require "rails_helper"

RSpec.describe "User session" do
  describe "Users can login" do
    it "allows default user to log in" do
      user = User.create(name: "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456")

      visit '/login'

      fill_in :email,	with: "test@test.com"
      fill_in :password,	with: "123456"
      click_button "Login"

      expect(current_path).to eq("/profile")

      expect(page).to have_content("You are now logged in.")
      expect(user.role).to eq("default")
    end

    it "allows merchant user to log in" do
      user =  create(:user,email: "test@test.com", role: 1 )
# : "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456", role: 1)

      visit '/login'

      fill_in :email,	with: "test@test.com"
      fill_in :password,	with: "123456"
      click_button "Login"

      expect(current_path).to eq("/merchant/dashboard")

      expect(page).to have_content("You are now logged in.")
      expect(user.role).to eq("merchant")
    end

    it "allows admin user to log in" do
      user = User.create(name: "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456", role: 2)

      visit '/login'

      fill_in :email,	with: "test@test.com"
      fill_in :password, with: "123456"
      click_button "Login"

      expect(current_path).to eq("/admin/dashboard")

      expect(page).to have_content("You are now logged in.")
      expect(user.role).to eq("admin")
    end
  end

  describe "Sad path, bad credentials" do
    it "default user cannot log in with bad credentials. Wrong email." do
      user = User.create(name: "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456")

      visit '/login'

      fill_in :email,	with: "test2@test.com"
      fill_in :password, with: "123456"
      click_button "Login"

      expect(current_path).to eq('/login')
      expect(page).to have_content("Username and/or password are incorrect")
    end

    it "merchant user cannot log in with bad credentials. Wrong password" do
      user = User.create(name: "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456", role: 1)

      visit '/login'

      fill_in :email,	with: "test@test.com"
      fill_in :password, with: "1234456"
      click_button "Login"

      expect(current_path).to eq('/login')
      expect(page).to have_content("Username and/or password are incorrect")
    end
  end
end
