FactoryGirl.define do
  factory :bill do
    bill_type 'hres'
    chamber 'house'
    official_title { Faker::Lorem.sentence }
    congress 113
    introduced_on '2014-01-05'
    last_action_at '2014-01-06'
  end
end
