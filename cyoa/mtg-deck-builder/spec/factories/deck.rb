FactoryGirl.define do
  factory :deck do
    name { Faker::Name.name }
    user
  end
end
