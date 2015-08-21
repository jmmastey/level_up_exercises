FactoryGirl.define do
  factory :user do |f|
    f.username { Faker::Internet.user_name }
    f.password { Faker::Internet.password }
    f.password_confirmation { Faker::Internet.password }
    f.email { Faker::Internet.email }
  end
end
