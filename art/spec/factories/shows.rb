# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :show do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
  end
end
