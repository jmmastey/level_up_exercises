Given(/^I am logged into my account$/) do
  create_and_login_user
  visit("/")
  expect(page).to have_link("Log Out")
end

When(/^I enter an invalid minimum rating value$/) do
  fill_in("profile_min_rating", with: INVALID_MIN_RATING)
end

When(/^I save my settings$/) do
  click_button("profile_save")
end

When(/^I enter an invalid repeat interval value$/) do
  fill_in("profile_repeat_interval", with: INVALID_REPEAT_INTERVAL)
end

When(/^I enter a valid minimum rating value$/) do
  fill_in("profile_min_rating", with: VALID_MIN_RATING)
end

Then(/^I should see an error alert box$/) do
  expect(page).to have_css("div.alert-danger")
end

Then(/^I should see a success alert box$/) do
  expect(page).to have_css("div.alert-success")
end

When(/^I enter a valid repeat interval value$/) do
  fill_in("profile_repeat_interval", with: VALID_REPEAT_INTERVAL)
end

When(/^I click the Get Recommendation button$/) do
  click_button("get_rec_btn")
end

Given(/^a venue exists$/) do
  create_venue(1)
  fill_in("profile_min_rating", with: 0.0) 
end

Then(/^I should see a restaurant entry$/) do
  wait_for_ajax
  expect(page).to have_css("div#venue_rec")
end

Then(/^I should see a "Sold! I'm going" button$/) do
  expect(page).to have_css("#add_history_btn")
end

Given(/^the search settings do not match any venues$/) do
  fill_in("profile_min_rating", with: 10.0) 
end

Then(/^I should see a frowny face$/) do
  expect(page).to have_content(":-(")
end

Then(/^I should see an explanation message$/) do
  expect(page).to have_content("No venues found")
end
