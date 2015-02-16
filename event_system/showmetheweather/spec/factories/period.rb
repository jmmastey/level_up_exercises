FactoryGirl.define do
  factory :period_today, class: "Period" do
    name "Today"
    start "2015-02-02T06:00:00-06:00"
    self.end "2015-02-02T18:00:00-06:00"
    after(:create) do |period|
      create(:prediction_high_temp, period: period)
      create(:prediction_precipitation_50, period: period)
      create(:prediction_conditions_sunny, period: period)
    end
  end

  factory :period_tonight, class: "Period" do
    name "Tonight"
    start "2015-02-02T18:00:00-06:00"
    self.end "2015-02-03T06:00:00-06:00"
    after(:create) do |period|
      create(:prediction_low_temp, period: period)
      create(:prediction_precipitation_25, period: period)
      create(:prediction_conditions_cloudy, period: period)
    end
  end
end
