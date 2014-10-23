require "faker"

FactoryGirl.define do
  factory :location do |f|
    f.address1 { Faker::Address.street_address }
    f.city { Faker::Address.city }
    f.state { Faker::Address.state_abbr }
    f.postal_code { Faker::Address.postcode }
  end

  factory :ohare_location, class: Location do |f|
    f.address1 "10000 W O'Hare Ave"
    f.city "Chicago"
    f.state "IL"
    f.postal_code "60666"
  end
end
