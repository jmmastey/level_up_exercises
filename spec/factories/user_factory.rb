FactoryGirl.define do
  factory :user do
    first_name "Paul"
    last_name "Haddad"
    email "user@artsy.com"
    password "secret"
    password_confirmation "secret"
  end
end
