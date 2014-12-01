require 'faker'

FactoryGirl.define do
  factory :bill do
    bill_id { Faker::Lorem.characters(9) }
    short_title { Faker::Lorem.sentence }
  end
end
