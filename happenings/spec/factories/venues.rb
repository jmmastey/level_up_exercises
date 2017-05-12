# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    sequence(:name) { |i| "Venue#{i}" }
    venue_url "http://www.irock.com"
    phone_number "17736794909"

    description "I am a cool venue"
    zipcode "60645"
    city "Chicago"
    address "123 Elm Street"

    factory :invalid_venue do
      name nil
      venue_url nil
      description nil
      zipcode nil
      city nil
      address nil
      phone_number nil

    end

  end
end
