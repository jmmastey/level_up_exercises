FactoryGirl.define do
  factory :card do
    sequence(:name) { |n| "test_card#{n}" }
  end
end
