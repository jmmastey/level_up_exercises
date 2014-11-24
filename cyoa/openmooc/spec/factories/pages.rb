# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    type ""
    section

    factory :example_lesson_page do
      association :activity, factory: :example_lesson_activity
    end

    factory :example_fill_in_the_blank_question_page do
      association :activity, factory: :example_quiz_activity
    end

    factory :page_with_fill_in_the_blank_question do
      association :activity, factory: :quiz_activity_with_fill_in_the_blank_question
    end
  end
end
