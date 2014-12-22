FactoryGirl.define do
  factory :event do
    title         "My Event"
    description   "At A Place"
    time          Time.now
    date          Date.today
    url           "http://www.awesomeness.com"
    event_source  :theatre_in_chicago
  end

  factory :event_source do
    event_source  :theatre_in_chicago
    description   "a source of coolness"
  end

  sequence(:username) do |n|
    "test_#{n}"
  end
  sequence(:email) do |n|
    "test_#{n}@enova.com"
  end

  factory :user do
    username
    email
    encrypted_password  "dude"
    password            "test_password"
  end
end
