require "rails_helper"

RSpec.describe "Merchant Edit Item" do
    before :each do
        @merchant = create(:merchant)
    
        @merchant_user  = create(:user, merchant: @merchant, email: 'merchant@test.com',  role: 1)
        @item_1 = create(:item, merchant: @merchant)
        @item_2 = create(:item, merchant: @merchant)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
    end

    it "has edit button" do
      visit "/merchant/items"
      within "#item-#{@item_1.id}" do
        expect(page).to  have_content("Edit Item")
        click_on "Edit Item"
        expect(current_path).to  eq("/merchant/items/#{@item_1.id}/edit")
      end
    end

    it "can edit an item" do
        visit "/merchant/items/#{@item_1.id}/edit"
        expect(find_field(:name).value).to  eq(@item_1.name)
        expect(find_field(:description).value).to  eq(@item_1.description)
        expect(find_field(:price).value).to  eq(@item_1.price.to_s)
        expect(find_field(:image).value).to  eq(@item_1.image)
        expect(find_field(:inventory).value).to  eq(@item_1.inventory.to_s)

        fill_in :name,	with: "Lg Thinq"
        fill_in :price,	with: "299" 
        click_on "Edit Item"

        expect(current_path).to  eq("/merchant/items")

        within "#item-#{@item_1.id}" do
            expect(page).to  have_content("Lg Thinq")
            expect(page).to  have_content("299")
            expect(page).to  have_content("Active")
        end

        expect(page).to have_content("Item updated successfully.") 
    end
    
    it "can rise error for blank fields" do
        visit "/merchant/items/#{@item_1.id}/edit"
        
        fill_in :name,	with: "Lg Thinq"
        fill_in :price,	with: "" 
        click_on "Edit Item"
        
        expect(current_path).to  eq("/merchant/items/#{@item_1.id}/edit")
        expect(page).to have_content("[\"Price can't be blank\", \"Price is not a number\"]") 
    end
end