# Create a user

FactoryGirl.define do
  factory :user do
    name "John Doe"
    email "john@example.com"
    password_digest <%= User.digest('password') %>
    admin false
    activated true
    activated_at <%= Time.zone.now %>
  end

  factory :admin, class: User do
    name "Admin User"
    email "admin@example.com"
    password_digest <%= User.digest('password') %>
    admin true
    activated true
    activated_at <%= Time.zone.now %>
  end
end

