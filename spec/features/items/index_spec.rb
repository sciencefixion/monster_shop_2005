require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).to have_link(@dog_bone.name)
      expect(page).to have_link(@dog_bone.merchant.name)
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

      within "#item-#{@dog_bone.id}" do
        expect(page).to have_link(@dog_bone.name)
        expect(page).to have_content(@dog_bone.description)
        expect(page).to have_content("Price: $#{@dog_bone.price}")
        expect(page).to have_content("Inactive")
        expect(page).to have_content("Inventory: #{@dog_bone.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@dog_bone.image}']")
      end
    end

    it "does not allow disabled items to show in the items index" do
      # User Story 17, Items Index Page
      #
      # As any kind of user on the system
      # I can visit the items catalog ("/items")
      # I see all items in the system except disabled items
      #
      # The item image is a link to that item's show page
      @lemarchand = Merchant.create(name: "LeMarchand Boxes", address: '1717 Rue de L\'Académie Royale', city: 'Paris', state: 'TX', zip: 75460)

      @lament = @lemarchand.items.create(name: "Lament Configuration", description: "We have such sights to show you!", price: 999, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", active?:false, inventory: 6, enabled?:false)

      visit '/items'

      expect(page).to_not have_link(@lament.name)
      expect(page).to_not have_content(@lament.description)
      expect(page).to_not have_content("Price: $#{@lament.price}")
      save_and_open_page
      expect(page).to_not have_content("Inventory: #{@lament.inventory}")
      expect(page).to_not have_link(@lemarchand.name)
      expect(page).to_not have_css("img[src*='#{@lament.image}']")

    end

    xit "links to an item's show page via its image" do
      visit '/items'

      click_on @dog_bone.image

      expect(current_path).to eq("/items/#{@dog_bone.id}")
    end
  end
end
