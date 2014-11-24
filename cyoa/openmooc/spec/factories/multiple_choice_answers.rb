# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :multiple_choice_answer do
    multiple_choice_question
    text 'incorrect answer'
    correct false

    factory :incorrect_multiple_choice_answer do
    end

    factory :correct_multiple_choice_answer do
      text 'correct answer'
      correct true
    end
  end
end
