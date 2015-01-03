Given /^I am not logged in$/ do
end

Given /^I am on the homepage$/ do
  visit_home
end

Then /^I see 'good deeds' link$/ do
  expect(page).to have_link('Good Deeds')
end

Then /^I see 'bills' link$/ do
  expect(page).to have_link('Bills')
end

Then /^I see 'legislators' link$/ do
  expect(page).to have_link('Legislators')
end
