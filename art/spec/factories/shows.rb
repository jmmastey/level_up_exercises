# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :show do
    name { Faker::Company.catch_phrase }
    description { Faker::Lorem.sentence }
    year { rand(1990..2200) }
    director { Faker::Name.name }
    theatre_company { Faker::Company.name }
    notes { Faker::Lorem.paragraph(1, true, 5) }
    location { Faker::Address.street_address }

    trait(:with_performances) do
      after(:create) { |show| create_list(:performance, 10, show: show) }
    end
  end
end
