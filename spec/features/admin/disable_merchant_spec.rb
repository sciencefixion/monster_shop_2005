require 'rails_helper'

RSpec.describe "Admin disables a merchant account" do
    before :each do
        @admin_user = create(:user , email: 'test@test1.com',  role: 2 )
        @default_user = create(:user)
        @default_user_2 = create(:user)

        @merchant_1 = create(:merchant)
        @merchant_2 = create(:merchant)
        @merchant_3 = create(:merchant, enabled: false)
        @merchant_4 = create(:merchant)

        @item_1 = create(:item, merchant: @merchant_4)
        @item_2 = create(:item, merchant: @merchant_1)
        @item_3 = create(:item, merchant: @merchant_2)
        @item_4 = create(:item, merchant: @merchant_1)
        @item_5 = create(:item, merchant: @merchant_2)
        @item_6 = create(:item, merchant: @merchant_3)
        @item_7 = create(:item, merchant: @merchant_2)
        @item_8 = create(:item, merchant: @merchant_1)
        @item_9 = create(:item, merchant: @merchant_3)
        @item_10 = create(:item, merchant: @merchant_1)
        @item_11 = create(:item, merchant: @merchant_4)
        @item_12 = create(:item, merchant: @merchant_2)
        @item_13 = create(:item, merchant: @merchant_3)
        @item_14 = create(:item, merchant: @merchant_2, enabled?: false)
        
        @order_1 = create(:order , user: @default_user, status: 1)
        @order_2 = create(:order , user: @default_user)
        @order_3 = create(:order , user: @default_user, status: 2)
        @order_4 = create(:order , user: @default_user, status: 1)
        @order_5 = create(:order , user: @default_user, status: 3)
        @order_6 = create(:order , user: @default_user_2)
        @order_7 = create(:order , user: @default_user_2, status: 1)
        
        visit '/login'

        within  "form" do
            fill_in :email,	with: "test@test1.com" 
            fill_in :password,	with: "123456" 
            click_on 'Login'
        end
        
    end

    it "page has disable buttons" do
        visit "/admin/merchants"

        within "#merchant-#{@merchant_1.id}" do
            expect(page).to  have_link("disable")
        end

        within "#merchant-#{@merchant_2.id}" do
            expect(page).to  have_link("disable")
        end
    end

    it "Admin disables a merchant account" do
        visit "/admin/merchants"

        within "#merchant-#{@merchant_1.id}" do
            click_on "disable"
        end
        expect(page).to  have_content("#{@merchant_1.name} has been disabled")
    end
    
    it "has enabled link when disabled" do
        visit "/admin/merchants"
        
        within "#merchant-#{@merchant_3.id}" do
            expect(page).to  have_link("enable")
            click_on "enable"
        end
        expect(page).to  have_content("#{@merchant_3.name} has been enabled")

        visit "/merchants/#{@merchant_3.id}/items"

        @merchant_3.items.each do |item|
            within "#item-#{item.id}" do
                expect(page).to have_content('Active') 
            end
        end
    end    
end