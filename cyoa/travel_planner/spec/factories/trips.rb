require "faker"

FactoryGirl.define do
  factory :trip do
    association :home_location, factory: :location
  end

  factory :lga_trip, class: Trip do
    association :home_location, factory: :laguardia_location
    meetings {[FactoryGirl.create(:meeting_lga)]}
  end
end
