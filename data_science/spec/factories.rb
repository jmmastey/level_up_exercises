FactoryGirl.define do
  factory :data_point, class: DataScience::DataPoint do
    date "2014-11-10"
    cohort "A"
    result 0
  end
end
