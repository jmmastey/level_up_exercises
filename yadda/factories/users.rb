FactoryGirl.define do
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
