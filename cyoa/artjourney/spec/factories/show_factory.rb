FactoryGirl.define do
  factory :show do
    sequence(:name) { |n| "Show-#{n}"}
  end
end
