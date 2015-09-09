FactoryGirl.define do
  factory :character do
    sequence(:id) { |n| "#{n}" }
    name "MyString"
    realm "MyString"
    blizzard_faction_id_num "1"
  end
end
