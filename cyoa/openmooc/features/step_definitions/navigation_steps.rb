When(/^I click "(.*?)"$/) do |text|
  click_on(text)
end

When(/^I click first "(.*?)"$/) do |text|
  click_on(text, match: :first)
end

Given(/^I am on the about page$/) do
  visit(about_path)
end
