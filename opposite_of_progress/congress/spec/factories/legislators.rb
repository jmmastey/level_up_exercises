require 'faker'

FactoryGirl.define do
  factory :legislator do |l|
    l.bioguide_id { Faker::Lorem.characters(7) }
    l.title { Faker::Name.title }
    l.first_name { Faker::Name.first_name }
    l.nickname { Faker::Hacker.noun }
    l.last_name { Faker::Name.last_name }
    l.party { Faker::Lorem.characters(1) }
  end
end