require 'faker'

FactoryGirl.define do
  factory :user_session do
    session_key { Faker::Lorem.characters(40) }
    last_activity { Time.now }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    miles_radius { rand(1..50) }
  end
end
