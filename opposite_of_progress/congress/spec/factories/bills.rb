require 'faker'

FactoryGirl.define do
  factory :bill do |b|
    b.bill_id { Faker::Lorem.characters(9) }
    b.short_title { Faker::Lorem.sentence }
  end
end