FactoryGirl.define do
  factory :character do
    sequence(:id) { |n| "#{n}" }
    name { "name#{id}" }
    realm "MyString"
  end
end
