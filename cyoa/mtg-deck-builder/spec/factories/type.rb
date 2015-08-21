FactoryGirl.define do
  factory :type do
    sequence(:name) { |n| "#{Faker::Lorem.word}#{n}" }
  end
end
