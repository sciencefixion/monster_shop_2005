require 'rails_helper'

RSpec.describe "User can log out" do
  before(:each) do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

  end
  it "can log a default user out" do
    jim = User.create(name: "Jim", address: "3455 LKV Rd.", city: "Denver", state: "CO", email: "test@test.com", zip: "80124", password: "123456")
    visit '/login'
    fill_in :email,	with: "test@test.com"
    fill_in :password,	with: "123456"
    click_button "Login"
    expect(jim.role).to eq("default")

    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"
    expect(page).to have_content("Cart: 2")

    click_on "Log Out"

    expect(current_path).to eq("/")
    expect(page).to have_content("You are logged out")
    expect(page).to have_content("Cart: 0")
  end
end
