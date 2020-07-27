FactoryBot.define do
    factory :item_order do
      order
      item
      price { rand(1..1000) }
      quantity { rand(1..66) }
    end
  end