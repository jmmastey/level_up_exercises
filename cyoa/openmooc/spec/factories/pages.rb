# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    type ""
    lesson

    factory :example_page do
      association :content, factory: :example_content

      factory :page_with_content
    end

    factory :example_fill_in_the_blank_question_page do
      association :content, factory: :example_fill_in_the_blank_question
    end
  end
end
