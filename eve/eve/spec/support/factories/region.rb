FactoryGirl.define do
  factory :region do
    name "Malpais"

    sequence(:in_game_id, 10000001)
  end
end
