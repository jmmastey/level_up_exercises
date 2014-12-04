attr_reader :lesson

def lesson_with_pages
  @lesson ||= FactoryGirl.create(:lesson_with_pages)
end

def lesson_with_course
  @lesson ||= FactoryGirl.create(:course_with_lessons).lessons.first
end

def new_lesson
  @lesson ||= FactoryGirl.build(:lesson)
end

def lesson_params(lesson)
  { 'Name' => lesson.name }
end

def new_name_params
  { 'Name' => 'Brand spanking new name' }
end

def easy_html_remove(text)
  text.gsub(/<\/?[^>]+?>/, '')
end

### GIVEN ###

Given(/^I am on a course lesson page$/) do
  visit(lesson_path(lesson_with_course))
end

### WHEN ###

When(/^I enter new lesson information$/) do
  enter_form(lesson_params(new_lesson))
end

When(/^I enter new lesson name$/) do
  enter_form(new_name_params)
end

### THEN ###

Then(/^I should see a new lesson name on the course page$/) do
  expect(page).to have_content(new_name_params['Name'])
end

Then(/^I should see a new lesson on the course page$/) do
  expect(page).to have_content(new_lesson.name)
end

Then(/^I should not see new lesson info$/) do
  expect(page).not_to have_content(new_lesson.name)
end

Then(/^I should see new content on the lesson page$/) do
  page_content = easy_html_remove(
    lesson.pages.first.content.page_content.to_s)
  expect(page).to have_content(page_content)
end

Then(/^I should see one more lesson page$/) do
  expect(page).to have_content('2 Lesson material')
end
