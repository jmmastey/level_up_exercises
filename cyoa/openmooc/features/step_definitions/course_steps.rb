def course
  @course ||= FactoryGirl.create(:course)
end

def new_course
  @new_course ||= FactoryGirl.build(:new_course)
end

def course_with_one_section
  @course ||= FactoryGirl.create(:section).course
end

def course_with_sections
  @course ||= FactoryGirl.create(:course_with_sections)
end

def course_to_params(course)
  course.slice(:title, :description, :subject, :topic)
    .inject({}) do |params, (key, value)|
    params.tap { |p| p[key.capitalize] = value }
  end
end

##### GIVEN #####

Given(/^The course has sections$/) do
  course_with_sections
end

Given(/^a course with one section$/) do
  course_with_one_section
end

Given(/^I am on a course page$/) do
  visit(course_path(course))
end

Given(/^I am on an edit course page$/) do
  visit(edit_course_path(course))
end

Given(/^I am on the edit sections page$/) do
  visit(edit_sections_course_path(course))
end

Given(/^I am on the courses page$/) do
  visit(courses_path)
end

### WHEN ###

When(/^I enter new course information$/) do
  enter_form(course_to_params(new_course))
end

### THEN ###

Then(/^I should be on the courses page$/) do
  expect(current_path).to eq(courses_path)
end

Then(/^I should see the new course information$/) do
  expect(page).to have_content(new_course.title)
end

Then(/^I should be on the edit sections page$/) do
  expect(current_path).to eq(edit_sections_course_path(course))
end

Then(/^I should see section links$/) do
  course_with_sections.sections.each do |section|
    expect(page).to have_content(section.name)
  end
end
