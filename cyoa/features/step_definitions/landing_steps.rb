Then(/^I see weather information$/) do
  expect(page).to have_content("weather information")
end

Then(/^I see a register now option$/) do
  expect(page).to have_link("register_link")
end

Then(/^I see a login option$/) do
  expect(page).to have_link("login_link")
end

Then(/^I see a logout option$/) do
  expect(page).to have_link("logout_link")
end

Then(/^I see a settings option$/) do
  pending # express the regexp above with the code you wish you had
end