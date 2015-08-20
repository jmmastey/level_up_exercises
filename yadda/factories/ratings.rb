FactoryGirl.define do
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
    beer
    user
  end
end
