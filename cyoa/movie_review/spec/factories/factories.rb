require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.email }
    f.password "fake_password"
  end

  factory :movie do |m|
  	m.name { Faker::Name.name }
  	m.release_date { Faker::Date.backward(14) }
  	m.poster_path { Faker::Avatar.image("jpg") }
  end

  factory :review do |r|
  	r.rating { Faker::Number.between(1, 5) }
  	r.comment { Faker::Company.catch_phrase }
  end
end