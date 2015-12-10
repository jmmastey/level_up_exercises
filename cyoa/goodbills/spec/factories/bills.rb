FactoryGirl.define do
  factory :bill do
    sequence(:official_title) {|n| "title-#{n}"}
  end
end