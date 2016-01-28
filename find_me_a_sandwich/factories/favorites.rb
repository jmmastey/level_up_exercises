FactoryGirl.define do
  factory :favorite do
    association :user
    association :menu_item
  end
end
