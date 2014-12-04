# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content do
    page_content
    page

    factory :example_content
  end
end
