When(/^I go to a page that does not exist$/) do
  visit "/asdf"
end

Then(/^I will get a 404 page$/) do
  expect(page).to have_title "#fail"
end
