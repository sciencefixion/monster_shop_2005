require 'rails_helper'

RSpec.describe "Merchant sees an order show page" do
  it "order show page" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)

    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant_2)

    merchant_user = create(:user, merchant: merchant, role: 1)
    default_user_1 = create(:user)
    default_user_2 = create(:user)

    order_1 = create(:order, user: default_user_1, status: 1)
    order_2 = create(:order, user: default_user_1)
    order_3 = create(:order, user: default_user_2)

    item_order_1 = create(:item_order, item: item_1, order: order_1)
    item_order_2 = create(:item_order, item: item_1, order: order_2)
    item_order_3 = create(:item_order, item: item_2, order: order_2)
    item_order_3 = create(:item_order, item: item_3, order: order_2)
    item_order_4 = create(:item_order, item: item_2, order: order_3)


    visit "/login"
    within "form" do
      fill_in :email, with: merchant_user.email
      fill_in :password, with: merchant_user.password
      click_on "Login"
    end

    click_on "#{order_2.id}"

    expect(current_path).to eq("/merchant/orders/#{order_2.id}")
    expect(page).to have_content(order_2.user.name)
    expect(page).to have_content(order_2.address)
    expect(page).to have_link(item_1.name) # TO ITEM SHOW PAGE
    expect(page).to have_link(item_2.name) # TO ITEM SHOW PAGE
    expect(page).to have_link(item_1.image)
    expect(page).to have_link(item_2.image)
    expect(page).to have_link(item_1.price)
    expect(page).to have_link(item_2.price)
    expect(page).to have_link(item_1.quantity) # QUANTITY USER WANTS TO PURCHASE
    expect(page).to have_link(item_2.quantity) # QUANTITY USER WANTS TO PURCHASE
    expect(page).to_not have_content(item_3.name)
  end
end


## psudeo code

# merchants "fulfill" each ordered item for users.
# merchant visits an order show page which will allow them to mark each item as fulfilled
# once every merchant marks their items for an order as fulfill, then the whole order switches to "packaged"
# Merchants cannot fulfill items in an order if they do not have enough inventory in stock
#If user cancels order after a merchant has fulfilled an item, the quantity of that item is returned to the merchant

## ADMIN functionality

# Admin can ship orders (story 33)
# Admin can fulfill items in an order on behalf of a merchant (EXTENSION)
