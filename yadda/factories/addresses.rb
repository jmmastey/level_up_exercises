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
end
