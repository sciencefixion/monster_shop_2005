require 'rails_helper'

RSpec.describe "User views an oder show page" do
  before :each do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    @bert = User.create(name: "Bert", address: "123 Sesame St.", city: "NYC", state: "New York", zip: "10001", email: "bert@test.com", password: "123456")

    visit '/login'
    fill_in :email,	with: "bert@test.com"
    fill_in :password,	with: "123456"
    click_button "Login"

    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/cart"
    click_on "Checkout"
    fill_in :name, with: @bert.name
    fill_in :address, with: @bert.address
    fill_in :city, with: @bert.city
    fill_in :state, with: @bert.state
    fill_in :zip, with: @bert.zip
    click_button "Create Order"

    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/cart"
    click_on "Checkout"
    fill_in :name, with: @bert.name
    fill_in :address, with: @bert.address
    fill_in :city, with: @bert.city
    fill_in :state, with: @bert.state
    fill_in :zip, with: @bert.zip
    click_button "Create Order"


    @order1 = Order.first
    @order2 = Order.last

  end

  it "text" do
    visit "/profile/orders"

    click_on "#{@order2.id}"
    save_and_open_page
    expect(current_path).to eq("/profile/orders/#{@order2.id}")
    expect(page).to have_content(@order2.id)
    expect(page).to have_content(@order2.date_created)
    expect(page).to have_content(@order2.date_last_updated)
    expect(page).to have_content(@order2.status)
    expect(page).to have_content(@paper.name)
    expect(page).to have_content(@paper.description)
    # expect(page).to have_content(@paper.image)
    expect(page).to have_content(@paper.quantity_ordered)
    expect(page).to have_content(@paper.price)
    expect(page).to have_content("$100.00")
    expect(page).to have_content(@tire.name)
    expect(page).to have_content(@tire.description)
    # expect(page).to have_content(@tire.image)
    expect(page).to have_content(@tire.quantity_ordered)
    expect(page).to have_content(@tire.price)
    expect(page).to have_content("$300.00")
    expect(page).to have_content(@order2.total_quantity_of_items)
    expect(page).to have_content(@order2.grandtotal)
  end
end
