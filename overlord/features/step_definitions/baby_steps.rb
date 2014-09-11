Given /^I am on the arming page$/ do
  visit "/"
end
   
Then /^I should see "([^"]*)"$/ do |text|
  expect(page).to have_content text
end

Then /^I should not see "([^"]*)"$/ do |text|
  expect(page).to have_no_content text  
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in field, with: value
end

When /^I click "([^"]*)"$/ do |element|
  click_on element
end

Given /^I have activated the bomb$/ do
  steps %{
    'I am on the arming page'
    'I fill in "activation_code" with "1234"'
    'I click "submit"'
  }
end

Then /^I reset$/ do
  steps %{
  	'I fill in "deactivation_code" with "1234"'
    'I click "submit"'
  }
end

Then /^I dump the page$/ do
  puts body
end

When /^I navigate to "([^"]*)"$/ do |page|
  visit "#{page}"
end

When /^I refresh the page$/ do
  visit current_path
end

When /^I move forward "(\d+)" seconds in time$/ do |seconds|
  Timecop.travel(Time.now + seconds.to_i)
  page.execute_script "if (window.clock) { window.clock.tick(#{seconds.to_i * 1000}); }"
end
