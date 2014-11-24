# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson_activity_with_content, class: LessonActivity do
    page_content
    page

    factory :example_lesson_activity
  end
end
