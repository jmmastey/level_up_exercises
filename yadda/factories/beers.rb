FactoryGirl.define do
  factory :beer do
    sequence :id
    style { %w(Ale Lager Hybrid).sample }
    name  { "#{Faker::Lorem.word} #{style}" }
    description { Faker::Lorem.paragraph }
    brewing_year { Faker::Date.between(Date.today - 2 * 365, Date.today).year }
    created_by 'factory'
    brewery
  end
end
