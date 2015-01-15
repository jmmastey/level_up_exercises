Given(/^"(.*?)" says "(.*?)"$/) do |selector_id, status_text|
  selector_id.should have_content(status_text)
end

Given(/^"(.*?)" is not configured$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given(/^"(.*?)" is configured to "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When(/^I enter right "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^"(.*?)" should contain "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^(?:|I )should see "([^\"]*)"(?: with id of textarea "([^\"]*)")?$/ \
do |text, selector|
  selector.should have_content("Inactive")
end