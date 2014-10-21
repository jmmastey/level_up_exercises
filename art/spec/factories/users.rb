# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.user_name + rand(1000..9999999).to_s }
    password "changeme"
  end
end
