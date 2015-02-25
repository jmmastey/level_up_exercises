FactoryGirl.define do
  factory :stock do
    symbol "FLWS"
    name "Flowers"
    sector "Technology"
    industry "Overhyped Products"
    ticker_trend "====="
  end

  factory :user do
    email "me2@me.com"
    password "12341234"

    trait :with_stocks do
      after(:create) do |user|
        create(:stock, users: [user])
      end
    end
  end
end