FactoryGirl.define do
  factory :user do
    email 'john@doe.org'
    first_name 'John'
    last_name 'Doe'
    password '12345678'
  end
end
