FactoryGirl.define do
  factory :user do
    provider 'google_oauth2'
    uid '00000'
    name 'Chris'
    oauth_token 'thisisafaketoken'
    oauth_expires_at '123456789'
  end

  factory :user2, class: User do
    provider 'google_oauth2'
    uid '00001'
    name 'John'
    oauth_token 'thisisafaketoken2'
    oauth_expires_at '123456789'
  end
end
