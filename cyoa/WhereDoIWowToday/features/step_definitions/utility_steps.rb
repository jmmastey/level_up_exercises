Then(/^I should see the "([^"]*)" field$/) do |field|
  expect(page).to have_field(field)
end

Then(/^I should see "([^"]*)"$/) do |message|
  expect(page).to have_content(message)
end

