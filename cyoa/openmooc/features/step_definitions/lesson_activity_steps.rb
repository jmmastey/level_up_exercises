
def create_lesson_activity
  @lesson_activity ||=
    FactoryGirl.create(:lesson_activity_with_content)
end

Given(/^I am on a lesson activity page$/) do
  visit(page_path(create_lesson_activity.page))
end
