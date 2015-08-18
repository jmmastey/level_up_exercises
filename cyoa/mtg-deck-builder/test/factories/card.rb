FactoryGirl.define do
  factory :card do
    sequence(:name) { |n| "test_card#{n}" }
    sequence(:text) { |n| "Some card text #{n}" }
  end
end
