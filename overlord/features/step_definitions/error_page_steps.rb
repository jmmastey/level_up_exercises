When(/^I go to a page that does not exist$/) do
  visit "/asdf"
end

Then(/^I will get a (\d+) page$/) do |arg1|
  expect(page).to have_title "#fail"
end
