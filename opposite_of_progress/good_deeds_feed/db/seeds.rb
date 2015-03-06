User.create!(name:  "Dariusz Dzien",
             email: "ddzien@enova.com",
             password:              "password",
             password_confirmation: "password",
             admin: true)

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
