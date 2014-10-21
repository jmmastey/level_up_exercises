# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :performance do
    association :show
    performed_on { rand(0.200).days.from_now }
  end
end
