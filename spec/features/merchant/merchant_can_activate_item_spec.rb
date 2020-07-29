require "rails_helper"

RSpec.describe "Merchant employee Acivae and Deactivate Item" do
    before :each do
        @merchant_1 = create(:merchant)
        @merchant_2 = create(:merchant)
        @merchant_3 = create(:merchant, enabled: false)
        @merchant_4 = create(:merchant)

        @merchant_user = create(:user, email: 'test@test12.com', merchant: @merchant_2, role: 1)

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
        @item_11 = create(:item, merchant: @merchant_4)
        @item_12 = create(:item, merchant: @merchant_2)
        @item_13 = create(:item, merchant: @merchant_3)
        @item_14 = create(:item, merchant: @merchant_2, enabled?: false)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
    end

    it "can has a deactivate button" do
        visit "/merchant/items"
        within "#item-#{@item_3.id}" do
           expect(page).to   have_content(@item_3.name)
           expect(page).to   have_content(@item_3.description)
           expect(page).to   have_content(@item_3.price)
           expect(page).to have_css("img[src*='#{@item_3.image}']")
           expect(page).to   have_content("Active")
           expect(page).to   have_content(@item_3.inventory)
           expect(page).to  have_link("Deactivate")
        end
        within "#item-#{@item_14.id}" do
            expect(page).to   have_content(@item_14.name)
            expect(page).to   have_content(@item_14.description)
            expect(page).to   have_content(@item_14.price)
            expect(page).to have_css("img[src*='#{@item_3.image}']")
            expect(page).to   have_content("Active")
            expect(page).to   have_content(@item_14.inventory) 
            expect(page).to  have_link("Deactivate")
        end
    end
    
    it "can deactivate item" do
        visit "/merchant/items"
        within "#item-#{@item_3.id}" do
            click_on "Deactivate"
        end
        expect(current_path).to  eq("/merchant/items")
        expect(page).to  have_content("#{@item_3.name} is no longer for sale")
        # within "#item-#{@item_3.id}" do
        #     expect(page).to  have_content("Inactive")
        #     expect(page).to  have_link("Activate")
        # end
    end
    it "can activate item" do
        visit "/merchant/items"
        within "#item-#{@item_5.id}" do
            expect(page).to  have_link("Activate")
            click_on "Activate"
        end
        expect(current_path).to  eq("/merchant/items")
        # within "#item-#{@item_5.id}" do
        #     expect(page).to  have_content("Active")
        #     expect(page).to  have_link("Deactivate")
        # end
    end

end