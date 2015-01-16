FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "testemail#{n}@example.com" }
    sequence(:password) { 'passWord01$' }
  end
end
