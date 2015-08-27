FactoryGirl.define do
  factory :address do
    sequence :id
    address_line_1 { Faker::Address.street_address }
    address_line_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code[0..4] }
    country 'US'
    created_by 'factory'
  end

  factory :beer_style do
    sequence :id
    created_by 'factory'
  end

  factory :beer do
    sequence :id
    name { "#{Faker::Lorem.word}" }
    description { Faker::Lorem.paragraph }
    brewing_year { Faker::Date.between(Date.today - 2 * 365, Date.today).year }
    created_by 'factory'
    brewery
    beer_style_id { BeerStyle.all.sample.id }
  end

  factory :brewery do
    sequence :id
    name { Faker::Name.first_name << ' Brewery' }
    description { Faker::Lorem.paragraph }
    founding_year { Faker::Date.between(Date.today - 2 * 365, Date.today).year }
    created_by 'script'
    address

    after(:create) do |brewery|
      FactoryGirl.create_list(:beer, 100, brewery_id: brewery.id)
    end
  end

  factory :rating do
    sequence :id
    look { (rand * 5).round(2) }
    smell { (rand * 5).round(2) }
    feel { (rand * 5).round(2) }
    taste { (rand * 5).round(2) }
    overall { [look, smell, feel, taste].inject(:+).to_f / 4 }
    notes { Faker::Lorem.sentences(4).join(' ') }
    created_on { Faker::Date.between(2.years.ago, Date.today) }
    created_by 'factory'
    beer_id { rand(1..Beer.count) }
    user_id { rand(1..User.count) }
  end

  factory :user do
    sequence :id
    fname { Faker::Name.first_name }
    lname { Faker::Name.last_name }
    username { Faker::Internet.user_name }
    age { Faker::Number.between(21, 125) }
    weight_in_lbs { Faker::Number.between(10, 500) }
    height_in_inches { Faker::Number.between(36, 100) }
    email { Faker::Internet.email }
    address
    created_by 'factory'
  end
end
