FactoryGirl.define do
  factory :watch do
    association :item
    association :user

    trait :with_nickname do
      sequence(:nickname) { |i| "Watch #{i}" }
    end

    trait :filter_by_region do
      association :region
    end

    trait :filter_by_station do
      association :station
    end
  end
end
