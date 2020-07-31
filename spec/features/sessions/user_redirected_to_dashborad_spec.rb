require "rails_helper"

RSpec.describe "user redirected to the dashboard", type: :feature do
    it "regular user back redirected to profile page" do
        user = User.create(name: "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456", role: 0)
        visit '/login'
        
        within  "form" do
            fill_in :email,	with: "test@test.com" 
            fill_in :password,	with: "123456" 
            click_on 'Login'
        end

        visit "/login"
        expect(current_path).to  eq('/profile')
    end

    it "admin user back redirected to profile page" do
        user = User.create(name: "Michael", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456", role: 2)
        visit '/login'
        within  "form" do
            fill_in :email,	with: "test@test.com" 
            fill_in :password,	with: "123456" 
            click_on 'Login'
        end

        visit "/login"
        expect(current_path).to  eq("/admin/dashboard")

    end 

    it "merchant user back redirected to profile page" do
        user = create(:user ,email: "test@test.com", role: 1 )
        visit '/login'
        within  "form" do
            fill_in :email,	with: "test@test.com" 
            fill_in :password,	with: "123456" 
            click_on 'Login'
        end

        visit "/login"
        expect(current_path).to  eq("/merchant/dashboard")

    end 
end
