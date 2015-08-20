FactoryGirl.define do
  factory :deck do
    sequence(:name) { |n| "test_deck#{n}" }
    user
  end
end
