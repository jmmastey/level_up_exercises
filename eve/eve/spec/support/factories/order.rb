FactoryGirl.define do
  factory :order do
    association :item
    association :region
    association :station

    security 0.8
    price 1.50
    order_type "sell"
    date_pulled Date.new(2014, 11, 1)

    sequence(:in_game_id, 1)
  end
end
