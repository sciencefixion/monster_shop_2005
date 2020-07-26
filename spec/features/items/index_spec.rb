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
      @lemarchand = Merchant.create(name: "LeMarchand Boxes", address: '1717 Rue de L\'Académie Royale', city: 'Paris', state: 'TX', zip: 75460)

      @lament = @lemarchand.items.create(name: "Lament Configuration", description: "We have such sights to show you!", price: 999, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", active?:false, inventory: 6, enabled?:false)

      visit '/items'

      expect(page).to_not have_link(@lament.name)
      expect(page).to_not have_content(@lament.description)
      expect(page).to_not have_content("Price: $#{@lament.price}")
      expect(page).to_not have_content("Inventory: #{@lament.inventory}")
      expect(page).to_not have_link(@lemarchand.name)
      expect(page).to_not have_css("img[src*='#{@lament.image}']")

    end

    it "links to an item's show page via its image" do

      visit '/items'

      within "#item-image-#{@dog_bone.id}" do
        click_on "#{@dog_bone.name}"
      end

      expect(current_path).to eq("/items/#{@dog_bone.id}")
    end

    it "displays statistics for the 5 most and least popular items" do

          #     User Story 18, Items Index Page Statistics
          #
          # As any kind of user on the system
          # When I visit the items index page ("/items")
          # I see an area with statistics:
          # - the top 5 most popular items by quantity purchased, plus the quantity bought
          # - the bottom 5 least popular items, plus the quantity bought
          #
          # "Popularity" is determined by total quantity of that item ordered

      @lemarchand = Merchant.create(name: "LeMarchand Boxes", address: '1717 Rue de L\'Académie Royale', city: 'Paris', state: 'TX', zip: 75460)

      item1 = @lemarchand.items.create(name: "Lament Configuration", description: "We have such sights to show you!", price: 999, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", inventory: 11 )
        item2 = @lemarchand.items.create(name: "Two", description: "We have such sights to show you!", price: 10, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", inventory: 11 )
          item3 = @lemarchand.items.create(name: "Three", description: "We have such sights to show you!", price: 10, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", inventory: 11 )
            item4 = @lemarchand.items.create(name: "Four", description: "We have such sights to show you!", price: 10, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", inventory: 11 )
              item5 = @lemarchand.items.create(name: "Five", description: "We have such sights to show you!", price: 10, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", inventory: 11 )
                item6 = @lemarchand.items.create(name: "Six", description: "We have such sights to show you!", price: 10, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", inventory: 15 )
                  item7 = @lemarchand.items.create(name: "Seven", description: "We have such sights to show you!", price: 10, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", inventory: 15 )
                    item8 = @lemarchand.items.create(name: "Eight", description: "We have such sights to show you!", price: 10, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", inventory: 15 )
                      item9 = @lemarchand.items.create(name: "Nine", description: "We have such sights to show you!", price: 10, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", inventory: 15 )
                        item10 = @lemarchand.items.create(name: "Ten", description: "We have such sights to show you!", price: 10, image: "https://vignette.wikia.nocookie.net/cenobite/images/f/fa/Lament_Configuration.jpg", inventory: 15 )

      order1 = Order.create(name: "Homer", address: "1234 What St.", city: "Springfield", state: "IL", zip: "12345")
        order2 = Order.create(name: "Ned", address: "", city: "Springfield", state: "IL", zip: "12345")
          order3 = Order.create(name: "Moe", address: "", city: "Springfield", state: "IL", zip: "12345")
            order4 = Order.create(name: "Bart", address: "1234 What St.", city: "Springfield", state: "IL", zip: "12345")
              order5 = Order.create(name: "Lisa", address: "1234 What St.", city: "Springfield", state: "IL", zip: "12345")

      10.times { ItemOrder.create(item: item1, order: order1) }
        9.times { ItemOrder.create(item: item2, order: order2) }
          8.times { ItemOrder.create(item: item3, order: order3) }
            7.times { ItemOrder.create(item: item4, order: order4) }
              6.times { ItemOrder.create(item: item5, order: order5) }
                5.times { ItemOrder.create(item: item6, order: order1) }
                  4.times { ItemOrder.create(item: item7, order: order2) }
                    3.times { ItemOrder.create(item: item8, order: order3) }
                      2.times { ItemOrder.create(item: item9, order: order4) }
                        1.times { ItemOrder.create(item: item10, order: order5) }

      visit '/items'

      within "#stats" do
        expect(page).to have_content("Top 5 Most Popular Items:")
        #   #expect items and quantity

        expect(page).to have_content("Bottom 5 Least Popular Items:")
        #   #expect items and quantity
      end

    end
  end
end
