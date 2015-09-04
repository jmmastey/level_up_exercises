FactoryGirl.define do
  factory :term do
    month 1
    year Time.now.year
    user_id 1
  end
end
