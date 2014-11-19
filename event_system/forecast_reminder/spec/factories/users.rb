require 'faker'

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    station_id "KMDW"
    zip_code Faker::Address.zip_code

    after(:build) { |u| u.password = Faker::Internet.password }
  end

end
