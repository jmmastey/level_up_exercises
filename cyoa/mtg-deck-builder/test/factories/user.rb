FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "test_user#{n}" }
    password "123456"
    password_confirmation "123456"
    email { "#{username}@example.com" }
  end
end