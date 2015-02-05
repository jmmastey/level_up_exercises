FactoryGirl.define do  factory :forecast_type do
    
  end
  factory :forecast_weather_type do
    
  end
  factory :weather_type do
    
  end
  factory :forecast do
    
  end
  factory :point do
    
  end

  factory :user do
    email    'jeremy@example.com'
    phone    '630-849-2299'
    password 'secret123'
  end

  factory :user_notification do
    user
    notification_time '06:00:00'
    active            true
  end
end