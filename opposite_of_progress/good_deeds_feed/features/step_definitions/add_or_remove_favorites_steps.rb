def log_in(user)
end

Given(/^I am at a legislator's page$/) do
  visit("/legislators/1")
end

Given(/^a user exists and is logged in$/) do
  user = FactoryGirl.create(:user)
  visit("/login/")
  fill_in("Email", with: user.email)
  fill_in("Password", with: user.password)
  click_button("Log in")
  expect(page).to have_selector(".user_info")
end

Then(/^I see a link to add the legislator to my favorites$/) do
  expect(page).to have_selector(".new_favorite")
end

When(/^I add the legislator to my favorites$/) do
  click_button("Add to favorites")
end

Then(/^I see the legislator in my favorites$/) do
  expect(page).to have_selector(".favorite-1")
end

Given(/^the legislator is already in my favorites$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I see a link to remove the legislator from my favorites$/) do
  expect(page).to have_selector(".edit_favorite")
end

When(/^I remove the legislator from my favorites$/) do
  click_button("Remove from favorites")
end

Then(/^the legislator is removed my favorites$/) do
  expect(page).not_to have_selector(".favorite-1")
end
