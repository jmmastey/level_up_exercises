FactoryGirl.define do
  factory :legislator do
    title 'Rep'
    first_name { Faker::Name.first_name }
    middle_name 'MyString'
    last_name { Faker::Name.last_name }
    nickname 'MyString'
    party 'D'
    state 'IL'
    district '2'
    in_office true
    gender 'M'
    phone 'MyString'
    fax 'MyString'
    website 'MyString'
    contact_form 'MyString'
    office 'MyString'
    bioguide_id 'MyString'
    votesmart_id 'MyString'
    twitter_id 'MyString'
    youtube_id 'MyString'
    facebook_id 'MyString'
    birthday { 35.years.ago }
    term_start '2015-01-03'
    term_end '2017-01-06'
    oc_email 'email@opencongress.org'
  end
end
