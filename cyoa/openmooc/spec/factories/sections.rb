# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :section, class: Section do
    name 'User Created Section Name'
    course

    factory :section_with_pages do
      pages { create_list(:page, 3) }
    end

    factory :example_section do
      pages do
        create_list(:example_lesson_page, 3) +
        create_list(:example_fill_in_the_blank_question_page, 1)
      end
    end
  end
end
