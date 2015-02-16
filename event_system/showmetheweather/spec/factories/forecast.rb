FactoryGirl.define do
  factory :forecast do
    zip_code "60606"
    after(:create) do |forecast|
      create(:period_today, forecast: forecast)
      create(:period_tonight, forecast: forecast)
    end
  end

  factory :another_forecast, class: "Forecast" do
    zip_code "90210"
    after(:create) do |forecast|
      create(:period_today, forecast: forecast)
      create(:period_tonight, forecast: forecast)
    end
  end
end
