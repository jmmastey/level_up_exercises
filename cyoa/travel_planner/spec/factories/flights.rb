require "faker"

FactoryGirl.define do
  factory :flight do
    origin_date_time { Faker::Time.forward(3, :morning).to_datetime }
    destination_date_time { Faker::Time.forward(3, :afternoon).to_datetime }
    flight_number { Faker::Lorem.characters(2) }
    carrier { Faker::Number.number(3) }
    association :destination_airport, factory: :airport
    association :origin_airport, factory: :airport
  end
end
