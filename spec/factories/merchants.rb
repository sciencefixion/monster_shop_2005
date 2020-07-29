FactoryBot.define do
    factory :merchant do
      name     { Faker::FunnyName.name }
      address  { Faker::Address.street_address }
      city     { Faker::Address.city }
      state    { Faker::Address.state_abbr }
      zip      { Faker::Address.zip }
    end
  end
  
