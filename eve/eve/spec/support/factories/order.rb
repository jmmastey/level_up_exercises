FactoryGirl.define do
  factory :order do
    association :item
    association :region
    association :station

    in_game_id 1311
    security 0.8
    price 1.50
    type "sell"
    date_pulled Date.new(2014, 11, 1)
  end
end
