require 'faker'

FactoryGirl.define do
  factory :current_weather do
    station_id "KMDW"
    temperature Random.rand(-32..120)
    condition %w"Rain Cloudy Sunny Partly-Cloudy Snow".sample
    location_name "Chicago Midway Airport, IL"
    observation_time "Last Updated on #{Time.now}"
    wind "West at 12.7 MPH (11 KT)"
    pressure "28.78"
    dew_point Random.rand(-32..100)
    wind_chill Random.rand(-32..100)
    visibility Random.rand(0.0..10.0)
    icon_url = Faker::Avatar.image
    history_url = Faker::Internet.url
  end
end
