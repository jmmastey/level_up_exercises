# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :multiple_choice_question do
    page_content
    quiz_activity
    answers []

    factory :multiple_choice_question_with_answers do
      answers do
        create_list(:correct_multiple_choice_answer, 1) +
        create_list(:incorrect_multiple_choice_answer, 3)
      end
    end
  end
end
