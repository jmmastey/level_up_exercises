FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
  end

  factory :named_user, class: User do
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    email { Faker::Internet.email("#{first_name} #{last_name}") }
    password { Faker::Internet.password(8) }
  end
end
