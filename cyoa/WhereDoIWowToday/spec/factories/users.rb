FactoryGirl.define do
  factory :user do
    sequence(:id) { |n| "#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password "1234567890"
    admin false

    factory :admin, class: User do
      admin true
    end
  end
end
