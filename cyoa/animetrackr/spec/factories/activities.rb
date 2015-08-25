FactoryGirl.define do
  factory :new_activity, class: Activity do
    activity 'Added'
    state 'Added'
    anime
    user
  end

  factory :currently_watching_activity, class: Activity do
    activity 'Currently Watching'
    state 'Updated'
    anime
    user
  end

  factory :done_watching_activity, class: Activity do
    activity 'Done Watching'
    state 'Updated'
    anime
    user
  end
end
