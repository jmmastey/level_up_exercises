FactoryGirl.define do
  factory :ebook do
    user_id 1
    title "Test Book"
    description "It's not a real book!"
    version "1.0"
    url "http://www.google.com"
    generated false
    language "en"
    publisher "Random House"
    subject "History"
    rights "None"
    readability true
    markdown ""
    epub ""
  end
end
