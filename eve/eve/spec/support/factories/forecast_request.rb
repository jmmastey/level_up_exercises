FactoryGirl.define do
  factory :forecast_request do
    association :item
    average_price 3.00
    history_start_time 1.years.ago
    history_end_time 6.months.ago
    max_price 12.00
    min_price 1.00
    num_target_days 1
    target_date Date.today
  end
end
