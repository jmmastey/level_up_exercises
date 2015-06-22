
Given(/^that I am on the boot page$/) do
  visit('/')
end

Then(/^I should see an activation code text box prefilled with an activation code (\d+)$/) do |arg1|
  find_field('activation_code').value.should == "1234"
end

Then(/^I should see a deactivation text box prefilled with a deactivation code (\d+)$/) do |arg1|
  find_field('deactivation_code').value.should == "0000"
end

When(/^I submit invalid codes$/) do
  fill_in('activation_code', with: "abcd")
  fill_in('deactivation_code', with: "9872")
  click_button('Boot Bomb')
end

Then(/^I should see an error message$/) do
  expect(page).to have_content("Please enter 4 digit numbers")
end

When(/^I submit valid codes$/) do
  fill_in('activation_code', with: "3456")
  fill_in('deactivation_code', with: "9872")
  click_button('Boot Bomb')
end

Then(/^my bomb should boot successfully$/) do
  expect(page).to have_content('Overlord! The bomb has been successfully booted')
  expect(page).to have_css("input.entered_activation_code")
end



