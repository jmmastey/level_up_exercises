# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    sequence :id
    title "Test Title"
    subject "Test Subject"
    topic "Test Topic"
    description "Test Description"

    factory :course_with_sections do
      sections { create_list(:section, 3) }
    end

    factory :example_course do
      sections { create_list(:example_section, 3) }
    end

    factory :new_course do
      title "New Title"
      subject "New Subject"
      topic "New Topic"
      description "New Description"
    end
  end
end
