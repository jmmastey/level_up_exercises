# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chart_song do
    chart_id "MyString"
    integer "MyString"
    song_id 1
    popularity 1
  end
end
