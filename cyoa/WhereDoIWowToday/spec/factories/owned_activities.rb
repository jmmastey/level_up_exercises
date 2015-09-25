FactoryGirl.define do
  factory :owned_activity do
    activity
    user
    hidden false
    index nil
  end
end
