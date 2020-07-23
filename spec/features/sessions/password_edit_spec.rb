require "rails_helper"

RSpec.describe "Password edit", type: :feature do
    describe "default user edit" do
        it "user can edit password" do
            user = User.create(name: "Michael", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456")
            visit '/login'
            within  "form" do
                fill_in :email,	with: "test@test.com" 
                fill_in :password,	with: "123456" 
                click_on 'Login'
            end
    
            visit '/profile'
    
            click_on 'edit password'
    
            fill_in :new_password,	with: "password" 
            fill_in :confirm_password,	with: "password" 
            click_on 'update'
    
            expect(current_path).to  eq('/profile')
    
            expect(page).to  have_content('Password updated')
        end
        it "user can edit password" do
            user = User.create(name: "Michael", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456")
            visit '/login'
            within  "form" do
                fill_in :email,	with: "test@test.com" 
                fill_in :password,	with: "123456" 
                click_on 'Login'
            end
    
            visit '/profile'
    
            click_on 'edit password'
    
            fill_in :new_password,	with: "password2" 
            fill_in :confirm_password,	with: "123456" 
            click_on 'update'
    
            expect(current_path).to  eq("/users/password/edit")
    
            expect(page).to  have_content("Password did not match")
        end
    end

end