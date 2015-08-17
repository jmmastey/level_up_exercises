FactoryGirl.define do
  factory :user do
    username 'zsyed'
    password 'ANice&Secure_1'
    password_confirmation 'ANice&Secure_1'
    email 'zsyed91@gmail.com'
    public true
  end

  factory :random_user, class: User do
    username { Faker::Internet.user_name(5..24) }
    password 'ANice&Secure_1'
    password_confirmation 'ANice&Secure_1'
    email { Faker::Internet.email }
    public true
  end

  factory :private_user, class: User do
    username { Faker::Internet.user_name(5..24) }
    password 'ANice&Secure_1'
    password_confirmation 'ANice&Secure_1'
    email { Faker::Internet.email }
    public false
  end
end
