FactoryGirl.define do
  factory :item do
    name "Tritanium"
    sequence(:in_game_id, 1)
  end
end
