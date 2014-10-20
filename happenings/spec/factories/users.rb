# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "test_user_#{i}@enova.com" }
    password "testtest"
    password_confirmation "testtest"
    confirmed_at {DateTime.current}


    factory :admin do
      sequence(:email) { |i| "admin_test_user_#{i}@enova.com" }
      superadmin {true}
    end
  end
end
