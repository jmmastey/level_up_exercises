require 'faker'

FactoryGirl.define do
  factory :forecast do
    zip_code 60606
    time Time.now + 1
    temperature Random.rand(-32..120)
    condition %w"Rain Cloudy Sunny Partly-Cloudy Snow".sample
    precipitation Random.rand(0..100)
    icon_url = Faker::Avatar.image
    date_description { "#{Date::DAYNAMES[time.wday]}" }
  end

end
