FactoryGirl.define do
  factory :event do
    title         "My Event"
    description   "At A Place"
    time          Time.now
    date          Date.today
    url           "http://www.awesomeness.com"
    event_source  { EventSource[:theatre_in_chicago] }
  end

  sequence(:name) do |n|
    "test_#{n}"
  end
  sequence(:email) do |n|
    "test_#{n}@enova.com"
  end

  factory :user do
    name
    email
    encrypted_password  "dude"
    password            "test_password"
  end
end
