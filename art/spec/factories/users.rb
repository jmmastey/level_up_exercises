# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Pete!"
    username "pete"
    password "changeme"
  end
end
