FactoryGirl.define do
  factory :cohort_json, class: Hash do
    cohort 'A'
    result 0

    initialize_with { attributes }

    trait :b_cohort do
      cohort 'B'
    end

    trait :converted_cohort do
      result 1
    end

    factory :b_cohort_json, traits: [:b_cohort]
    factory :converted_cohort_json, traits: [:converted_cohort]
  end
end
