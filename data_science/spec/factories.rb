FactoryGirl.define do
  factory :visit do
    cohort "A"
    date  "10-05-14"
    result 1
  end

  factory :cohort do
  	visits []
  	initialize_with { new(visits) }
  end
end