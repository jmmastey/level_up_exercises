require 'factory_girl'

FactoryGirl.define do
  factory :user do
    name "Cthulu"
    email "cthulu@rlyeh.com"
    password "password"
    admin false
    activated true
    activated_at -> { Time.zone.now }
  end

  factory :admin, class: User do
    name "Herbert West"
    email "herbert_west@thereanimator.com"
    password "password"
    admin true
    activated true
    activated_at -> { Time.zone.now }
  end
end
