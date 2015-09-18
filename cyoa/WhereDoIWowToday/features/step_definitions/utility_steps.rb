Then(/^I should see the "([^"]*)" field$/) do |field|
  expect(page).to have_field(field)
end

Then(/^I should see "([^"]*)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I should not see "([^"]*)"$/) do |message|
  expect(page).not_to have_content(message)
end
