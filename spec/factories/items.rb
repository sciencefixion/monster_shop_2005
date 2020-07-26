# This will guess the User class
FactoryBot.define do
  factory :random_item, class: Item do
    name { Faker::TvShows::SiliconValley.invention }
    description  { Faker::TvShows::MichaelScott.quote }
    price { rand(1..100) }
    image { "/assets/img01" + ".jpg" }
    inventory { rand(1..66) }
    merchant_id { rand() }

  end
end
