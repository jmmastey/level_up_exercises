When(/^I click the blacklist checkbox$/) do
  find("input[type='checkbox']").click
end

Then(/^the venue should be stored in the blacklist$/) do
  visit("/venues")
  checkbox = find("input[type='checkbox']")
  expect(checkbox).to be_checked
end

Given(/^I have blacklisted a venue$/) do
  create_venue(1)
  visit("/venues")
  find("input[type='checkbox']").click
  visit("/venues")
  checkbox = find("input[type='checkbox']")
  expect(checkbox).to be_checked
end

When(/^I clear the blacklist checkbox$/) do
  find("input[type='checkbox']").click
end

Then(/^the venue should be removed from the blacklist$/) do
  visit("/venues")
  checkbox = find("input[type='checkbox']")
  expect(checkbox).not_to be_checked
end


