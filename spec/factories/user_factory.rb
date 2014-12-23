FactoryGirl.define do
  factory :user do
    email "user@artsy.com"
    password "secret"
    password_confirmation "secret"
  end
end
