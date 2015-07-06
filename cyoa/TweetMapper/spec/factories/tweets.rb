require 'faker'

FactoryGirl.define do
  factory :tweet do
    tweet_id_from_twitter { Faker::Number.number(18) }
    author_name { Faker::Name.name }
    author_screen_name { Faker::Internet.user_name }
    tweet_text { Faker::Lorem.sentence(rand(1..8)) }
    favorite_count { Faker::Number.number(3) }
    retweet_count { Faker::Number.number(3) }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    tweet_created_at { Time.now }
  end
end
