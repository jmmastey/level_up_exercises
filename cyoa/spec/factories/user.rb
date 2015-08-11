FactoryGirl.define do
  factory :user do
    username "test_user"
    email "test_user@gmail.com"
    password "12345678"
    password_confirmation "12345678"
    first_name "Test"
    last_name "User"
    biography "I am a test user.  The guardian of the night."
  end
end
