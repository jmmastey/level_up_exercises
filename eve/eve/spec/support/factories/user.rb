FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "example#{i}@enova.com" }
    password "testtest1"
    password_confirmation "testtest1"
  end
end
