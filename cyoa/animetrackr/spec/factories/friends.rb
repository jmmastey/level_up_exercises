FactoryGirl.define do
  factory :friend do
    user user
    friend random_user
  end
end
