FactoryGirl.define do
  factory :data_point do
    date "2014-11-10"

    trait :control_group do
      cohort "A"
    end

    trait :test_group do
      cohort "B"
    end

    trait :non_conversion do
      result 0
    end

    trait :conversion do
      result 1
    end

    factory :control_group_no_conversion, traits: [:control_group, :non_conversion]
    factory :control_group_conversion, traits: [:control_group, :conversion]
    factory :test_group_no_conversion, traits: [:test_group, :non_conversion]
    factory :test_group_conversion, traits: [:test_group, :conversion]
  end
end
