require "faker"

FactoryGirl.define do
  factory :flight do
    origin_date_time { Faker::Time.forward(3, :morning).to_datetime }
    destination_date_time { Faker::Time.forward(3, :afternoon).to_datetime }
    association :destination_airport, factory: :airport
    association :origin_airport, factory: :airport
  end
end
