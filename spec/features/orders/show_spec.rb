require 'rails_helper'

RSpec.describe "Order show page" do
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

  it "User views their order's show page" do
    visit "/profile/orders"

    click_on "#{@order2.id}"

    expect(current_path).to eq("/profile/orders/#{@order2.id}")
    expect(page).to have_content(@order2.id)
    expect(page).to have_content(@order2.date_created)
    expect(page).to have_content(@order2.date_last_updated)
    expect(page).to have_content(@order2.status)
    expect(page).to have_content(@paper.name)
    expect(page).to have_content(@paper.description)
    expect(page).to have_css("img[src*='#{@paper.image}']")
    expect(page).to have_content("1")
    expect(page).to have_content(@paper.price)
    expect(page).to have_content("$100.00")
    expect(page).to have_content(@tire.name)
    expect(page).to have_content(@tire.description)
    expect(page).to have_css("img[src*='#{@tire.image}']")
    expect(page).to have_content(@tire.quantity_ordered)
    expect(page).to have_content(@tire.price)
    expect(page).to have_content("$200.00")
    expect(page).to have_content("2")
    expect(page).to have_content(@order2.grandtotal)
  end

  it "allows a user to cancel an order" do
     # User Story 30, User cancels an order
     #
     # As a registered user
     # When I visit an order's show page
     # I see a button or link to cancel the order
     # When I click the cancel button for an order, the following happens:
     # - Each row in the "order items" table is given a status of "unfulfilled"
     # - The order itself is given a status of "cancelled"
     # - Any item quantities in the order that were previously fulfilled have their quantities returned to their respective merchant's inventory for that item.
     # - I am returned to my profile page
     # - I see a flash message telling me the order is now cancelled
     # - And I see that this order now has an updated status of "cancelled"

     visit "/profile/orders/#{@order2.id}"

     click_on "Cancel Order"

     expect(current_path).to eq("/profile")
     expect(page).to have_content("Order number #{@order2.id} is now cancelled.")

     # expect(order.status).to eq("cancelled")
     visit "/profile/orders/#{@order2.id}"



   end
end

#namespace user as profile for profile orders
