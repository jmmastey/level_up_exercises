FactoryGirl.define do
  factory :visit do
    cohort "A"
    date "10-05-15"
    result 1
    initialize_with { new(attributes) }
  end

  factory :cohort do
    visits []
    initialize_with { new(attributes) }
  end
end
