FactoryGirl.define do
  factory :prediction_high_temp, class: "Prediction" do
    label "High Temperature"
    value "100"
  end

  factory :prediction_low_temp, class: "Prediction" do
    label "Low Temperature"
    value "75"
  end

  factory :prediction_precipitation_50, class: "Prediction" do
    label "Chance of Precipitation"
    value "50%"
  end

  factory :prediction_precipitation_25, class: "Prediction" do
    label "Chance of Precipitation"
    value "25%"
  end

  factory :prediction_conditions_sunny, class: "Prediction" do
    label "Conditions"
    value "Mostly Sunny"
  end

  factory :prediction_conditions_cloudy, class: "Prediction" do
    label "Conditions"
    value "Mostly Cloudy"
  end
end
