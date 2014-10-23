require "faker"

FactoryGirl.define do
  factory :trip do |f|
    association :home_location, factory: :location
  end
end
