FactoryGirl.define do
  factory :beer do
    sequence :id
    name  { "#{Faker::Lorem.word}" }
    description { Faker::Lorem.paragraph }
    brewing_year { Faker::Date.between(Date.today - 2 * 365, Date.today).year }
    created_by 'factory'
    brewery
    beer_style_id { BeerStyle.all.sample.id }
  end
end
