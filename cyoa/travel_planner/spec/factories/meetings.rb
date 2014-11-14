require "faker"

FactoryGirl.define do
  factory :meeting do
    start { Faker::Time.forward(3, :morning) }
    length 1.5
    location
  end

  factory :meeting_lga, class: Meeting do
    start { Faker::Time.forward(3, :morning) }
    length 1.5
    association :location, factory: :laguardia_location
  end
end
