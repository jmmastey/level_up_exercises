FactoryGirl.define do
  factory :type do
    sequence(:name) { |n| "test_type#{n}" }
  end
end
