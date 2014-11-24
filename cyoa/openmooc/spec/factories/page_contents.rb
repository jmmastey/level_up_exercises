# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page_content do
    content 'content'

    factory :too_much_page_content do
      content 'a' * 1501
    end
  end
end
