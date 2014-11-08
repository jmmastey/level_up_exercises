FactoryGirl.define do
  factory :watch do
    association :item
    association :user
  end
end
