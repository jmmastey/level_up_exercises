FactoryGirl.define do
  factory :merchant do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    phone { Faker::PhoneNumber.phone_number }
    association :location
  end
end
