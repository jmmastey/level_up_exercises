require 'data_science/cohort'

FactoryGirl.define do
  factory :cohort, class: DataScience::Cohort do
    initialize_with { new(no, yes) }

    factory :a_cohort do
      yes 100
      no 1_000
    end

    factory :b_cohort do
      yes 10_000
      no 1_000_000
    end
  end
end
