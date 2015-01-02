require "faker"
require_relative "models"

FactoryGirl.define do
  factory :address do
    sequence :id
    address_line_1 { Faker::Address.street_address }
    city { Faker::Address.city }
    region { Faker::Address.state }
    postal_code { Faker::Address.postcode }
    country "United States"
    created_by "script"
  end

  factory :brewery do
    sequence :id
    name { Faker::Company.name << " Brewery" }
    description { Faker::Company.catch_phrase }
    created_by "script"

    association :address

    trait :with_beers do
      after(:create) do |brewery|
        FactoryGirl.create_list(:beer, 20, brewery: brewery)
      end
    end
  end

  factory :beer do
    sequence :id
    style { "#{Faker::Name.first_name} #{["Lite", "IPA", "Lager"].sample}" }
    description { Faker::Lorem.sentence }
    year { Random.rand(1900..2015) }
    created_by "script"

    association :brewery
  end

  factory :user do
    sequence :id
    created_by "script"
    sequence(:username) { |i| Faker::Internet.user_name << i.to_s }
    email { Faker::Internet.email(username) }
    encrypted_password "testtest"
    active true
  end

  factory :rating do
    sequence :id
    created_by "script"

    look { Random.rand(1..5) }
    smell { Random.rand(1..5) }
    taste { Random.rand(1..5) }
    feel { Random.rand(1..5) }
    overall { (look + smell + taste + feel) / 4 }

    association :beer
    association :user
  end
end
