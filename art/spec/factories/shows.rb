# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :show do
    name { Faker::Company.catch_phrase }
    description { Faker::Lorem.sentence }
    year { rand(1990..2200) }
    director { Faker::Name.name }
    theatre_company { Faker::Company.name }
    notes { Faker::Lorem.paragraph(1, true, 5) }
    location { Faker::Address.street_address }
  end
end
