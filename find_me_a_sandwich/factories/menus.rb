FactoryGirl.define do
  factory :menu do
    name "Dinner"
    association :merchant

    trait :with_items do
      after(:create) do |menu|
        create_list(:menu_item, 20, menu: menu)
      end
    end
  end
end
