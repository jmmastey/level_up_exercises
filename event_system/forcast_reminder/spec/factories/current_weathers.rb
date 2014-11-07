FactoryGirl.define do
  factory :current_weather do
    zip_code 60606
    temperature Random.rand(-32..120)
    conditions %w"Rain Cloudy Sunny Partly-Cloudy Snow".sample
  end
end
