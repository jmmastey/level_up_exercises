# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :performance do
    association :show
    performed_on { Faker::Date.between(2.years.ago, 2.years.from_now) }
  end
end
