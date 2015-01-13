FactoryGirl.define do
  factory :bill do
    bill_type 'hres'
    chamber 'house'
    official_title { Faker::Lorem.sentence }
    congress 113
    introduced_on '2014-01-05'
    last_action_at { rand(1..100).days.ago }
    official_id { "#{bill_type}#{number}-#{congress}" }
  end
end
