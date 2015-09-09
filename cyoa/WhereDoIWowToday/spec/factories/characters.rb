FactoryGirl.define do
  factory :character do
    sequence(:id) { |n| "#{n}" }
    name { "name#{id}" }
    realm "MyString"
    blizzard_faction_id_num "1"
  end
end
