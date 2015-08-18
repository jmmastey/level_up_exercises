FactoryGirl.define do
  factory :brewery do
    sequence :id
    name { Faker::Name.first_name << ' Brewery' }
    description { Faker::Lorem.paragraph }
    founding_year { Faker::Date.between(Date.today - 2 * 365, Date.today).year }
    created_by 'script'
    address

    after(:create) do |brewery|
      FactoryGirl.create_list(:beer, 10_000, brewery_id: brewery.id)
    end
  end
end
