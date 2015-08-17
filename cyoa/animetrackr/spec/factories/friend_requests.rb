FactoryGirl.define do
  factory :friend_request do
    from user
    to fake_user
    message "Message to friend"
  end
end
