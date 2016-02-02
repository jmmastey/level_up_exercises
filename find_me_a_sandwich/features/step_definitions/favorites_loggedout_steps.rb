When(/^I visit the favorite meals list$/) do
  visit("/favorites/")
end

Then(/^I see a message prompting me to log in or create an account$/) do
  expect(page).to have_content('Login or signup to start saving favorites!')
end
