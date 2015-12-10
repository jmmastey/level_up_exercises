FactoryGirl.define do
  factory :bill do
    sequence(:title) {|n| "title-#{n}"}
  end
end