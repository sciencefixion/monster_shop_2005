
require 'rails_helper'

RSpec.describe "see all orders" do
    describe "display all orders" do
        before :each do
            @admin_user = create(:user , email: 'test@test1.com',  role: 2 )
            @default_user = create(:user)
        
            @order_1 = create(:order , user: @default_user, status: 1)
            @order_2 = create(:order , user: @default_user)
            @order_3 = create(:order , user: @default_user, status: 2)
            @order_4 = create(:order , user: @default_user, status: 1)
            @order_5 = create(:order , user: @default_user, status: 3)
            @order_6 = create(:order , user: @default_user)
            @order_7 = create(:order , user: @default_user, status: 1)
            
            visit '/login'
    
            within  "form" do
                fill_in :email,	with: "test@test1.com" 
                fill_in :password,	with: "123456" 
                click_on 'Login'
            end
            
        end
        
        it "Display all orders" do
            

            expect(current_path).to  eq("/admin/dashboard")
            within "#order-#{@order_1.id}" do
                expect(page).to  have_content(@order_1.id)
                expect(page).to  have_link(@order_1.user.name)
                expect(page).to  have_content(@order_1.created_at.in_time_zone("Mountain Time (US & Canada)").strftime("%B %d %Y"))
            end
        end

        it "can sort by order status" do
            expect(current_path).to  eq("/admin/dashboard")

            select "pending", from: :status
            click_on "find"
            
            expect(page).to have_content(@order_2.id)  
            expect(page).to have_content(@order_2.user.name)  
            
            expect(page).to have_content(@order_6.id)  
            expect(page).to have_content(@order_6.user.name)  
            
            expect(page).to_not have_content(@order_1.id)  
        end

        it "Go to admin users profile" do
            
            expect(current_path).to  eq("/admin/dashboard")
            within "#order-#{@order_1.id}" do
                click_on "Client: #{@order_1.user.name}"
            end

            expect(current_path).to  eq("/admin/users/#{@order_1.user.id}")

            expect(page).to have_content(@order_1.user.name) 
            expect(page).to have_content(@order_1.user.address) 
            expect(page).to have_content(@order_1.user.city) 
            expect(page).to have_content(@order_1.user.state) 
            expect(page).to have_content(@order_1.user.zip) 
        end
        
    end

    describe "Admin can 'ship' an order" do
        before :each do
            @admin_user = create(:user , email: 'test@test1.com',  role: 2 )
            @default_user = create(:user)
        
            @order_1 = create(:order , user: @default_user, status: 1)
            @order_2 = create(:order , user: @default_user)
            @order_3 = create(:order , user: @default_user, status: 2)
            @order_4 = create(:order , user: @default_user, status: 1)
            @order_5 = create(:order , user: @default_user, status: 3)
            @order_6 = create(:order , user: @default_user)
            @order_7 = create(:order , user: @default_user, status: 1)
            
            visit '/login'
    
            within  "form" do
                fill_in :email,	with: "test@test1.com" 
                fill_in :password,	with: "123456" 
                click_on 'Login'
            end
            
        end
        
        it "has a button changing the order status" do
            visit admin_dashboard_path
            
            within "#order-#{@order_1.id}" do
                expect(page).to  have_link("update to shipped")
            end
            within "#order-#{@order_4.id}" do
                expect(page).to  have_link("update to shipped")
            end
            
            within "#order-#{@order_2.id}" do
                expect(page).to_not  have_link("update to shipped")
            end
            within "#order-#{@order_3.id}" do
                expect(page).to_not  have_link("update to shipped")
            end

        end
        it "admin can change status to shipped" do
            visit admin_dashboard_path
            
            within "#order-#{@order_1.id}" do
                click_on "update to shipped"
            end
            within "#order-#{@order_1.id}" do
                expect(page).to  have_content("Order status: shipped")
            end

        end
        
    end
    
    
end
