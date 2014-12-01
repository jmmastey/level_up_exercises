require "faker"

FactoryGirl.define do
  factory :flight do
    origin_date_time { Faker::Time.forward(3, :morning) }
    destination_date_time { Faker::Time.forward(3, :afternoon) }
    association :destination_airport, factory: :airport
    association :origin_airport, factory: :airport
  end
end
