# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "factory_bot_rails"
include FactoryBot::Syntax::Methods

Merchant.destroy_all
Item.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

@admin_user = create(:user , email: 'admin@test.com',  role: 2 )
@default_user = create(:user)
@merchant_user = create(:user, merchant: bike_shop, email: 'merchant@test.com', role: 1 )

@order_1 = create(:order , user: @default_user, status: 1)
@order_2 = create(:order , user: @default_user)
@order_3 = create(:order , user: @default_user, status: 2)
@order_4 = create(:order , user: @default_user, status: 1)
@order_5 = create(:order , user: @default_user, status: 3)
@order_6 = create(:order , user: @default_user)
@order_7 = create(:order , user: @default_user, status: 1)

item = create(:item , merchant: bike_shop)
