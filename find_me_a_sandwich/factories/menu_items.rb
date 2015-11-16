FactoryGirl.define do
  factory :menu_item do
    sequence(:name) { |i| "Something something sandwich #{i}" }
    description { Faker::Lorem.sentence(2) }
    association :menu
  end
end
