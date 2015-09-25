FactoryGirl.define do
  factory :owned_activity do
    activity
    user
    hidden false
    index nil

    trait :goal do
      sequence(:index) { |n| "#{n}" }
    end
  end
end
