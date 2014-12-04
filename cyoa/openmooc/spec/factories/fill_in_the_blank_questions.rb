# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fill_in_the_blank_question do
    page_content
    answers []
    page

    factory :example_fill_in_the_blank_question do
      answers { create_list(:example_fill_in_the_blank_answer, 3) }
    end

    factory :fill_in_the_blank_question_with_answers do
      answers { create_list(:fill_in_the_blank_answer, 3) }
    end
  end
end
