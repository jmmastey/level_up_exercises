FactoryGirl.define do
  factory :bill do
    bill_id { Faker::Lorem.word << rand(100).to_s << '-114' }
    bill_type { %w(hr s hres sres sjres hjres hconres sconres).sample }
    chamber { %w(house senate).sample }
    congress 114
    cosponsors_count { rand(100) }
    introduced_on '2015-06-29'
    official_title 'MyString'
    popular_title 'MyString'
    short_title 'MyString'
    summary_short { Faker::Lorem.paragraph }
    url 'MyString'
    last_action_at '2015-07-29'
    last_version_pdf 'MyString'
    legislator
  end
end
