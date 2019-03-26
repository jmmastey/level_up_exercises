# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :review do
    association :user
    association :performance

    rating { rand(1..5) }
    review { Faker::Lorem.sentence }
  end
end
