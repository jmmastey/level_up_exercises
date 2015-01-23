FactoryGirl.define do
  factory :user do
    email    'jeremy@example.com'
    phone    '630-849-2299'
    password 'secret'
  end

  factory :user_notification do
    user
    notification_time '06:00:00'
    active            true
  end
end