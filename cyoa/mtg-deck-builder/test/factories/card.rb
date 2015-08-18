FactoryGirl.define do
  factory :card do
    sequence(:name) { |n| "test_card#{n}" }
    sequence(:text) { |n| "Some card text #{n}" }
    colors { %w(blue black white green red).sample(rand(0..5)) }
  end
end
