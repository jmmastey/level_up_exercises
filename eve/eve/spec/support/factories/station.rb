FactoryGirl.define do
  factory :station do
    name "Muvolailen X - Moon 3 - CBD Corporation Storage"

    sequence(:in_game_id, 60_000_001)
  end
end
