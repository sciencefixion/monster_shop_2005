require 'rails_helper'

RSpec.describe "User Registration" do
  it "user can register" do
      visit "/register"

      fill_in :name,	with: "Kwibe Merci" 
      fill_in :address,	with: "2345 MLK "
      fill_in :city,	with: "Denver"
      fill_in :state,	with: "CO"
      fill_in :zip,	with: "12345-0987"
      fill_in :email,	with: "test@test.com"
      fill_in :password,	with: "123456"
      fill_in :confirm_password,	with: "123456" 

    click_button "submit"
    
    expect(current_path).to eq("/profile")  
    # flash message
    expect(page).to have_content("Kwibe Merci has been registered and logged in") 
  end

  it "user fail registration" do
      visit "/register"

      fill_in :name,	with: "Kwibe Merci" 
      fill_in :address,	with: "2345 MLK "
      fill_in :city,	with: ""
      fill_in :state,	with: ""
      fill_in :zip,	with: "12345-0987"
      fill_in :email,	with: "test@test.com"
      fill_in :password,	with: "123456"
      fill_in :confirm_password,	with: "123456" 

    click_button "submit"
    
    expect(current_path).to eq("/register")  
    expect(page).to have_content("User could not be created: [\"City can't be blank\", \"State can't be blank\"]") 
  end

  it "user can register" do
    user = User.create!(name: "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456")
    visit "/register"

    fill_in :name,	with: "Kwibe Merci" 
    fill_in :address,	with: "2345 MLK "
    fill_in :city,	with: "Denver"
    fill_in :state,	with: "CO"
    fill_in :zip,	with: "12345-0987"
    fill_in :email,	with: "test@test.com"
    fill_in :password,	with: "123456"
    fill_in :confirm_password,	with: "123456" 

  click_button "submit"

  expect(current_path).to eq("/register")
  expect(page).to  have_content("User could not be created: [\"Email has already been taken\"]")
end
end
