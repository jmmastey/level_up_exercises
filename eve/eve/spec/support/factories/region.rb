FactoryGirl.define do
  factory :region do
    name "Malpais"

    sequence(:in_game_id, 10_000_001)
  end
end
