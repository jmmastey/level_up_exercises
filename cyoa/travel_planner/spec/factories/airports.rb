require "faker"

FactoryGirl.define do
  factory :airport do |f|
    f.name { "#{Faker::Lorem.word} Airport" }
    f.code { Faker::Lorem.characters(10) }
    location
  end

  factory :ord, class: :airport do |f|
    f.name "O'Hare International Airport"
    f.code "ORD"
    association :location, factory: :ord_location
  end

  factory :lga, class: :airport do |f|
    f.name "LaGuardia International Airport"
    f.code "LGA"
    association :location, factory: :lga_location
  end

end
