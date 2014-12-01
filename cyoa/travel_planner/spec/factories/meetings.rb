require "faker"

FactoryGirl.define do
  factory :meeting do
    start { Faker::Time.forward(3, :morning) }
    length 1.5
    location

    factory :meeting_lga, class: Meeting do
      association :location, factory: :lga_location
    end
  end
end
