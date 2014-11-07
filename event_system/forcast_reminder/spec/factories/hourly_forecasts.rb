FactoryGirl.define do
  factory :hourly_forecast do
    zip_code 60606
    time Time.zone.now + 3600
    temperature Random.rand(-32..120)
    dew_point Random.rand(0..100)
    precipitation Random.rand(0..100)
    wind_speed Random.rand(0..100)
    wind_direction Random.rand(0..360)
    cloud_cover Random.rand(0..100)
    hazard nil
  end

end
