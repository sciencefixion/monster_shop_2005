require "rails_helper"

RSpec.describe "add and deduct cart item" do
    before(:each) do
        @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 2)
        @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 5)

        visit "/items/#{@paper.id}"
        click_on "Add To Cart"
      end
    it "can add cart items" do
        visit cart_path

        within "#cart-item-#{@paper.id}" do
            within "center" do
                expect(page).to  have_link('+')
                click_on '+'
                expect(page).to  have_content('2')
            end
        end
    end
    it "can deduct cart items" do
        visit cart_path

        within "#cart-item-#{@paper.id}" do
            within "center" do
                expect(page).to  have_link('-')
                click_on '-'
                expect(page).to  have_content('0')
            end
        end
    end

    it "can add cart items beyond inventory size" do
        visit cart_path

        within "#cart-item-#{@paper.id}" do

            within "center" do
                click_on '+'
                expect(page).to_not  have_link('+')

            end
        end
    end

    it "can add cart items beyond inventory size" do
        visit cart_path

        within "#cart-item-#{@paper.id}" do

            within "center" do
                click_on '+'
                expect(page).to_not  have_link('+')

            end
        end
    end

    it "can not deduct cart items below 0" do
        visit cart_path

        within "#cart-item-#{@paper.id}" do

            within "center" do
                click_on '-'
                expect(page).to_not  have_link('-')

            end
        end
    end
    
end