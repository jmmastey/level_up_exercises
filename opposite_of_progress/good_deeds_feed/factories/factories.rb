FactoryGirl.define do
  factory :legislator do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    sequence(:bioguide_id) { |n| "DD#{n}001"}
    party %w( D R I ).sample
    state { Faker::Address.state_abbr }
    birthdate { Faker::Date.between(70.years.ago, 20.years.ago) }
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(10, 20) }
  end

  factory :good_deed do
    congress_number 114
    sequence(:congress_url) { |n| "http://beta.congress.gov/bill/114th/house-bill/#{n}" }
    short_title { Faker::Lorem.sentence }
    official_title { Faker::Lorem.sentence }
    introduced_on { Faker::Date.between(600.days.ago, 2.days.ago) }
    legislator
  end

end