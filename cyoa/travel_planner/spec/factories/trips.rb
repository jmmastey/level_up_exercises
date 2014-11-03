require "faker"

FactoryGirl.define do
  factory :trip do
    association :home_location, factory: :location
  end
end
