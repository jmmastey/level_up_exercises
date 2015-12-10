FactoryGirl.define do
  factory :bill do
    sequence(:official_title) {|n| "title-#{n}"}
    num_voted 2000
    score 250
    summary "this is a bill summary"
  end
end