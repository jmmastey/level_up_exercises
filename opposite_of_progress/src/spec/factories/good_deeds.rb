FactoryGirl.define do
  factory :good_deed do
    action 'voted'
    chamber 'house'
    acted_at '2014-01-12'
    bill

    trait :with_legislator do
      action 'sponsored'
      legislator
    end

    factory :good_deed_with_legislator, traits: [:with_legislator]
  end
end
