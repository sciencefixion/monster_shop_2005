FactoryBot.define do
    factory :item_order do
      price    { rand(1..1000) }
      quantity { rand(1..66) }
      item
      order
    end
  end
