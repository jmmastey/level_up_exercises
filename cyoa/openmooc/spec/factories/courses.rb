# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    sequence :id
    title "Test Title"
    subject "Test Subject"
    topic "Test Topic"
    description "Test Description"

    factory :course_with_lessons do
      lessons { create_list(:lesson, 3) }
    end

    factory :example_course do
      lessons { create_list(:example_lesson, 3) }
    end

    factory :new_course do
      title "New Title"
      subject "New Subject"
      topic "New Topic"
      description "New Description"
    end
  end
end
