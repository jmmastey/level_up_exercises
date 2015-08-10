FactoryGirl.define do
  factory :new_activity, class: Activity do
    activity 'Added'
    anime
    user
  end
end
