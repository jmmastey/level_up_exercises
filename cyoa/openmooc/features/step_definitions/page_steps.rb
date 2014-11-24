def activity_with_section
  @activity ||= FactoryGirl.create(
    :page,
    section: new_section,
    activity: FactoryGirl.create(:lesson_activity_with_content),
  )
end

def new_lesson_activity
  @activity ||= FactoryGirl.build(:lesson_activity_with_content)
end

def lesson_activity_params(activity)
  { 'Content' => activity.page_content.to_s }
end

Given(/^I am on an activity page$/) do
  visit(page_path(activity_with_section))
end

When(/^I enter new lesson activity content$/) do
  enter_form('Content' => 'Hello World!')
end

When(/^I enter edited lesson activity content$/) do
  enter_form('Content' => 'Hello World Again!')
end

Then(/^I should see the edited lesson activity content$/) do
  expect(page).to have_content('Hello World Again!')
end
