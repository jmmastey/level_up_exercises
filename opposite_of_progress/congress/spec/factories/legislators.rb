require 'faker'

FactoryGirl.define do
  factory :legislator do
    bioguide_id { Faker::Lorem.characters(7) }
    title { Faker::Name.title }
    first_name { Faker::Name.first_name }
    nickname { Faker::Hacker.noun }
    last_name { Faker::Name.last_name }
    party { Faker::Lorem.characters(1) }
  end
end
