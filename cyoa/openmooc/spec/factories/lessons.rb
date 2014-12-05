# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    name 'name'
    course

    factory :lesson_with_pages do
      pages { create_list(:page, 3) }
    end

    factory :example_lesson do
      pages do
        create_list(:example_content, 2) +
          create_list(:example_fill_in_the_blank_question, 1)
      end
    end
  end
end
