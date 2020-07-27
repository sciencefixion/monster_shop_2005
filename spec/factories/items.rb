# This will guess the User class
FactoryBot.define do
  factory :item do
    merchant
    name { Faker::TvShows::SiliconValley.invention }
    description  { Faker::TvShows::MichaelScott.quote }
    price { rand(1..100) }
    image { "/assets/img01" + ".jpg" }
    inventory { rand(1..66) }
  end
end
