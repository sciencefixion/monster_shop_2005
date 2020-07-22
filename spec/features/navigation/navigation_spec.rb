
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end
    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      # Next to the shopping cart link I see a count of the items in my cart
    end
    it "displays a link in navigation to welcome / home page of the application" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_link("Home")
      end

    end
    it "displays a link to login and register" do

      visit '/merchants'

      within 'nav' do
        expect(page).to have_link("Login")
        expect(page).to have_link("Register")
      end
    end
    it "restricts visitor access from merchant, admin, and profile views" do



      visit '/merchant/dashboard'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin/dashboard'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/profile'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
