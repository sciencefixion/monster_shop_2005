require "rails_helper"

RSpec.describe "Add item" do
    before :each do
        @merchant = create(:merchant)
    
        @merchant_user  = create(:user, merchant: @merchant, email: 'merchant@test.com',  role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
    end

    it "has button to add item" do
        visit "/merchant/items"
        expect(page).to  have_link("Add New Item")
        click_on "Add New Item"
        expect(current_path).to  eq("/merchant/items/new")
    end

    it "can create an item" do
        visit "/merchant/items/new"

        fill_in :name,	with: "LG Thinq" 
        fill_in :description,	with: "The best smart phone!" 
        fill_in :image,	with: "https://i-cdn.phonearena.com//images/reviews/216648-xgallery/LG-G7-ThinkQ-Review-TI.jpg" 
        fill_in :price,	with: "899"
        fill_in :inventory,	with: "3"

        click_on "Create Item"
        new_item = Item.last
        
        expect(current_path).to  eq("/merchant/items")
        expect(page).to  have_content("The Item has been created successfully.")

        within "#item-#{new_item.id}" do
            expect(page).to  have_content("LG Thinq")
            expect(page).to  have_content("The best smart phone!")
            expect(page).to  have_content("Active")
        end
    end

    it "can have a default thumbnail" do
        item = create(:item , merchant: @merchant_user.merchant )
        visit "/merchant/items"
        within "#item-#{item.id}" do
            expect(page).to  have_css("img[src*='https://tazacommune.com/wp-content/plugins/wp-appkit/default-themes/q-ios/img/img-icon.svg']")
        end
    end

    it "can create an item" do
        visit "/merchant/items/new"

        fill_in :name,	with: "LG Thinq" 
        fill_in :description,	with: "" 
        fill_in :image,	with: "https://i-cdn.phonearena.com//images/reviews/216648-xgallery/LG-G7-ThinkQ-Review-TI.jpg" 
        fill_in :price,	with: "899"
        fill_in :inventory,	with: ""

        click_on "Create Item"

        expect(current_path).to  eq("/merchant/items/new")
        expect(page).to  have_content("[\"Description can't be blank\", \"Inventory can't be blank\"]")
    end

end
