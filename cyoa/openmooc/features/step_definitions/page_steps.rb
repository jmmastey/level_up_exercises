def page_with_content
  @page ||= FactoryGirl.create(
    :page,
    lesson: new_lesson,
    content: FactoryGirl.create(:content),
  )
end

def content_page_params(page)
  { 'Content' => page.page_content.to_s }
end

Given(/^I am on an content page$/) do
  visit(page_path(page_with_content))
end

When(/^I enter new content page content$/) do
  enter_form('Content' => 'Hello World!')
end

When(/^I enter edited content page content$/) do
  enter_form('Content' => 'Hello World Again!')
end

Then(/^I should see the edited content page content$/) do
  expect(page).to have_content('Hello World Again!')
end
