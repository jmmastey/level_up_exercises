# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unregistered_user, class: User do
    email Faker::Internet.email
    password Faker::Internet.password(12)

    factory :registered_user do
      after(:create) { |user| user.confirm! }
    end
  end
end
