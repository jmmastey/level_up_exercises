require "faker"

FactoryGirl.define do
  factory :meeting do |f|
    f.start { Faker::Time.forward(3, :morning) }
    f.length 1.5
    location
  end
end
