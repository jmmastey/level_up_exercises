require "faker"

FactoryGirl.define do
  factory :airport do |f|
    f.name { "#{Faker::Lorem.word} Airport" }
    f.code { Faker::Lorem.characters(10) }
    location
  end

  factory :ohare, class: :airport do |f|
    f.name "O'Hare International Airport"
    f.code "ORD"
    association :location, factory: :ohare_location
  end
end
