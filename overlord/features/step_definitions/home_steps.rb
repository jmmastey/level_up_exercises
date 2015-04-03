Given(/^Super Villain has access to bomb console$/) do
  true
end

When(/^Super Villain visits home page$/) do
  visit('/')
end

Then(/^He should see bomb console screen$/) do
  expect(page).to have_button('Proceed to Boot')
end
