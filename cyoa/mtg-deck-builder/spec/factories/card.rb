FactoryGirl.define do
  factory :card do
    sequence(:name) { |n| "#{Faker::Name.name}#{n}" }
    text { Faker::Lorem.paragraph }
    cmc { Faker::Number.between(0, 20) }
    colors do
      [%w(blue black white green red).sample(rand(0..5)), nil][rand(1)]
    end
  end
end
