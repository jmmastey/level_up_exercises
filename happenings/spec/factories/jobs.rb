# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    title "MyString"
    location "MyString"
    link "MyText"
    haveapplied false
    company "MyString"
    interested false
    referred "MyString"
  end
end
