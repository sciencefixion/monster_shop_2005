require "rails_helper"

RSpec.describe "Merchant delete item" do
    before :each do
        @merchant_1 = create(:merchant)
        @merchant_2 = create(:merchant)
        @merchant_3 = create(:merchant, enabled: false)
        @merchant_4 = create(:merchant)

        @merchant_user = create(:user, email: 'test@test12.com', merchant: @merchant_2, role: 1)
        @default_user = create(:user)

        @item_1 = create(:item, merchant: @merchant_4)
        @item_2 = create(:item, merchant: @merchant_1)
        @item_3 = create(:item, merchant: @merchant_2)
        @item_4 = create(:item, merchant: @merchant_1)
        @item_5 = create(:item, merchant: @merchant_2, active?: false)
        @item_6 = create(:item, merchant: @merchant_3)
        @item_7 = create(:item, merchant: @merchant_2)
        @item_8 = create(:item, merchant: @merchant_1)
        @item_9 = create(:item, merchant: @merchant_3)
        @item_10 = create(:item, merchant: @merchant_1)
        @item_11 = create(:item, merchant: @merchant_2)
        @item_12 = create(:item, merchant: @merchant_2)
        @item_13 = create(:item, merchant: @merchant_3)
        @item_14 = create(:item, merchant: @merchant_2, enabled?: false)

        @order_1 = create(:order , user: @default_user)
        @order_2 = create(:order , user: @default_user)
    
        create(:item_order, order: @order_1, item: @item_12 )
        create(:item_order, order: @order_1, item: @item_3 )

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
    end

    it "page has delete button" do
       visit "/merchant/items"
       within "#item-#{@item_5.id}" do
            expect(page).to  have_link("Delete")
       end 
       within "#item-#{@item_7.id}" do
            expect(page).to  have_link("Delete")
       end 
    end

    it "item has no delete button if ordered" do
       visit "/merchant/items"
       within "#item-#{@item_3.id}" do
            expect(page).to_not  have_link("Delete")
       end 
       within "#item-#{@item_12.id}" do
            expect(page).to_not  have_link("Delete")
       end 
    end

    it "can delete item" do
        visit "/merchant/items"
        within "#item-#{@item_11.id}" do
            click_on "Delete"
        end 
        expect(current_path).to  eq("/merchant/items")
        expect(page).to  have_content("Item has been deleted.")
        expect(page).to_not  have_content("item-#{@item_11.id}")#***
    end
     
end
