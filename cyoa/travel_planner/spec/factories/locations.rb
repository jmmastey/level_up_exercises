require "faker"

FactoryGirl.define do
  factory :location do
    address1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    postal_code { Faker::Address.postcode }
  end

  factory :ord_location, class: Location do
    name "O'Hare"
    address1 "10000 W O'Hare Ave"
    city "Chicago"
    state "IL"
    postal_code "60666"
  end

  factory :lga_location, class: Location do
    name "LaGuardia"
    address1 "LaGuardia Airport"
    city "New York"
    state "NY"
    postal_code "11371"
  end
end
