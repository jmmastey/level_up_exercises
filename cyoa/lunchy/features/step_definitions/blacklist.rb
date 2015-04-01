When(/^I click the blacklist checkbox$/) do
puts page.body
  find("input[type='checkbox']").click
end

Then(/^the venue should be stored in the blacklist$/) do
  true
end

Given(/^I have blacklisted a venue$/) do
  create_venue(1)
  visit("/venues")
  find("input[type='checkbox']").click
  visit("/venues")
end

When(/^I clear the blacklist checkbox$/) do
  find("input[type='checkbox']").click
end

Then(/^the venue should be removed from the blacklist$/) do
  pending # express the regexp above with the code you wish you had
end


