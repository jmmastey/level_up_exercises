Given(/^I have not started a bomb$/) do
end

When /^I start the app$/ do
  visit "/"
end

Then /^I should see "([^\"]*)"$/ do |content|
  expect(page).to have_content(/#{content}/i)
end

Then /^I should be on the "([^\"]*)" page$/ do |p|
  expect(page).to have_css("##{p}")
end
