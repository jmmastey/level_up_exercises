FactoryGirl.define do
  factory :forecast do
    target_date Date.today
    association :forecast_request
  end
end
