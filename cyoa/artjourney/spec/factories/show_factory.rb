FactoryGirl.define do
  factory :show do
    sequence(:title) { |n| "Show-#{n}"}
  end
end
