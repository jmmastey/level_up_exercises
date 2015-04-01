def parent(field_id)
  find_field(field_id).find(:xpath, ".//..")
end

When(/^I click the signup button$/) do
  click_link('Sign Up')
end

Then(/^I should be on the (.*?) page$/) do |arg1|
  current_path = URI.parse(current_url).path
  expected_path = (arg1 == "home") ? "/" : "/#{arg1}"
  expect(current_path).to eql(expected_path)
end

When(/^I leave the signup fields empty$/) do
  fill_in("user_name", with: "")
  fill_in("user_email", with: "")
  fill_in("user_password", with: "")
  fill_in("user_password_confirmation", with: "")
end

When(/^I enter valid values in the signup fields$/) do
  fill_in("user_name", with: VALID_NAME)
  fill_in("user_email", with: VALID_EMAIL)
  fill_in("user_password", with: VALID_PASSWORD)
  fill_in("user_password_confirmation", with: VALID_PASSWORD)
end

When(/^I do not enter a name$/) do
  fill_in("user_name", with: "")
end

When(/^I attempt to create an account$/) do
  click_button("Create account")
end

Then(/^I should see an error message$/) do
  expect(page).to have_selector("#errors")
end

Then(/^the (name|email|password) field should be highlighted$/) do |arg1|
  field = parent("user_#{arg1}")
  expect(field[:class]).to eq("field_with_errors")
end

When(/^I do not enter an email$/) do
  fill_in("user_email", with: "")
end

When(/^I do not enter a password$/) do
  fill_in("user_password", with: "")
end

When(/^I do not enter a password confirmation$/) do
  fill_in("user_password_confirmation", with: "")
end

Then(/^the confirm password field should be highlighted$/) do
  field = parent("user_password_confirmation")
  expect(field[:class]).to eq("field_with_errors")
end

When(/^I enter valid values in all fields$/) do
  fill_in("user_name", with: VALID_NAME)
  fill_in("user_email", with: VALID_EMAIL)
  fill_in("user_password", with: VALID_PASSWORD)
  fill_in("user_password_confirmation", with: VALID_PASSWORD)
end

Then(/^I should see the user account page$/) do
  current_path = URI.parse(current_url).path
  expect(current_path).to eq("/")
  expect(page).to have_link("Log Out")
end
