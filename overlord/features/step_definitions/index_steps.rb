When /^I am on the welcome page$/ do
  @index = Index.new
  @index.load
end

Then /^the index page should contain the title and welcome link$/ do
  expect(@index).to be_displayed
  expect(@index).to have_title_head
  expect(@index).to have_welcome_link
end

When(/^I enter Megaton$/) do
  click_link "Enter Megaton"
end

Then(/^I should be directed to the bomb page$/) do
  @bomb_page = BombPage.new
  expect(@bomb_page).to be_displayed
end
