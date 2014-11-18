require 'faker'

FactoryGirl.define do
  factory :bill do |b|
    b.bill_id { Faker::Name.bill_id }
    b.short_title { Faker::Name.short_title }
  end
end