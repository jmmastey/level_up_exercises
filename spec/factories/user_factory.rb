FactoryGirl.define do
  factory :user do
    first_name "paul"
    last_name "haddad"
    email "user@artsy.com"
    password "secret"
    password_confirmation "secret"
  end
end
