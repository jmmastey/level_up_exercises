

Given(/^I am on the photos page$/) do
  visit "/viewphotos"
  expect(page).to have_content('Enova')
end

Then(/^I see Michelle in the photo description$/) do
  expect(page).to have_content('Michelle')
end

Then(/^I see the photos sorted by happiness$/) do
  expect(page).to have_content('happiness')
end