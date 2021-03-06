require "rails_helper"

RSpec.describe "User restrictions", type: :feature do
    describe "merchants restrictions" do
        it "merchant cannot use admin routes" do
            user = create(:user, email: "test@test.com", role: 1)
            visit '/login'
            
            within  "form" do
                fill_in :email,	with: "test@test.com" 
                fill_in :password,	with: "123456" 
                click_on 'Login'
            end
    
            visit "/admin/dashboard"
    
            expect(page).to  have_content("The page you were looking for doesn't exist (404)")
        end
        
    end
    
    describe "admin restrictions" do
        it "admin cannot access merchant and cart routes" do
            user = User.create(name: "Michael", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456", role: 2)
            visit '/login'
            within  "form" do
                fill_in :email,	with: "test@test.com" 
                fill_in :password,	with: "123456" 
                click_on 'Login'
            end
    
            visit "/cart"
            expect(page).to  have_content("Forbidden to access this route.")
            
            visit "/merchant/dashboard"
            expect(page).to  have_content("The page you were looking for doesn't exist (404)")
        end  
    end
end
