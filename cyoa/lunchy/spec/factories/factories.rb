require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    f.email { Faker::Internet.email }
  end

  factory :profile do |f|
    f.user_id { Faker::Number.digit }
    f.repeat_interval { Faker::Number.number(2) }
    f.min_rating { "#{Faker::Number.digit}.#{Faker::Number.digit}" }
    f.distance { Faker::Number.number(3) }
  end

  factory :venue do |f|
    f.venue_id { Faker::Internet.password(24) }
    f.name { Faker::Company.name }
    f.street { Faker::Address.street_address }
    f.distance { Faker::Number.number(3) }
    f.rating { "#{Faker::Number.digit}.#{Faker::Number.digit}" }
    f.url { Faker::Internet.url }
    f.category_name { Faker::Internet.slug }
    f.category_icon_prefix "https://ss3.4sqi.net/img/categories_v2/food/breakfast_"
    f.category_icon_suffix ".png"
  end

  factory :history do |f|
    f.venue_id { Faker::Number.digit }
    f.user_id { Faker::Number.digit }
    f.visited { Faker::Date.between(10.days.ago, Date.today) }
  end

  factory :blacklist do |f|
    f.venue_id { Faker::Number.digit }
    f.user_id { Faker::Number.digit }
  end
end
