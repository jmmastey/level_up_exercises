Given(/^I have navigated to the site$/) do
  visit "/"
end

When(/^I enter my zip code$/) do
  fill_in "forecast[zip_code]", :with => "60606"
  click_button "Show Me The Weather!"
end

Then(/^I see today's weather forecast$/) do
  expect(find("#forecast")).to have_content("Today")
  expect(find("#today-high")).to have_content("100")
  expect(find("#today-precip")).to have_content("50%")
  expect(find("#today-conditions")).to have_content("Mostly Sunny")
end

Then(/^I see tonight's weather forecast$/) do
  expect(find("#forecast")).to have_content("Tonight")
  expect(find("#tonight-low")).to have_content("75")
  expect(find("#tonight-precip")).to have_content("25%")
  expect(find("#tonight-conditions")).to have_content("Mostly Cloudy")
end

Then(/^I see the week's weather forecast$/) do
  expect(page).to have_css("#week-forecast") 
end

When(/^I enter an invalid zip code$/) do
  fill_in "forecast[zip_code]", with: "1234"
  click_button "Show Me The Weather!"
end

Then(/^I see an error$/) do
  expect(page).to have_css(".alert-danger")
end

Given(/^I am not signed in$/) do
  visit "/"
end

When(/^I sign up$/) do
  visit new_user_registration_path
  fill_in "Name", with: "John Smith"
  fill_in "Email", with: "johnsmith@gmail.com"
  fill_in "ZIP code", with: "60606"
  fill_in "Password", with: "abcd1234"
  fill_in "Password confirmation", with: "abcd1234"
  click_button "Sign up"
end

Then(/^I see that I am signed in$/) do
  expect(page).to have_content("Signed In As John Smith")
end

Given(/^I am signed in$/) do
  visit new_user_registration_path
  fill_in "Name", with: "John Smith"
  fill_in "Email", with: "johnsmith@gmail.com"
  fill_in "ZIP code", with: "60606"
  fill_in "Password", with: "abcd1234"
  fill_in "Password confirmation", with: "abcd1234"
  click_button "Sign up"
end

When(/^I update my profile$/) do
  visit edit_user_registration_path
  fill_in "ZIP code", with: "90210"
  fill_in "Current password", with: "abcd1234"
  click_button "Update"
end

Then(/^my profile is updated$/) do
  visit edit_user_registration_path
  expect(find("#user_zip_code").value).to eq("90210")
end
