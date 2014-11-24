# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fill_in_the_blank_answer do
    text 'Test Answer'
    fill_in_the_blank_question

    factory :example_fill_in_the_blank_answer
  end
end
