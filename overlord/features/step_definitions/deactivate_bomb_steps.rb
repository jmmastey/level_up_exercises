require 'pry'
Given(/^that I am on the countdown bomb page$/) do
  visit('/')
  fill_in('activation_code', with: "3456")
  fill_in('deactivation_code', with: "9872")
  click_button('Boot Bomb')
  fill_in('entered_activation_code', with: "3456")
  click_button('activate')
end

When(/^I submit an invalid deactivation code$/) do
  fill_in('entered_deactivation_code', with: "bcde")
  click_button('deactivate')
end

Then(/^I should see a deactivation code error message$/) do
  expect(page).to have_content('Please enter a valid 4 digit deactivation number')
end

When(/^I submit a valid deactivation code$/) do
  find('#entered_deactivation_code').set "9872"
  click_button('deactivate')

end

Then(/^the bomb should be deactivated$/) do
  expect(page).to have_content('Nice! You were able to deactivate the bomb!')
end


When(/^I submit an invalid deactivation code three times$/) do
  fill_in('entered_deactivation_code', with: "acde")
  click_button('deactivate')
  fill_in('entered_deactivation_code', with: "12345")
  click_button('deactivate')
  fill_in('entered_deactivation_code', with: "lmnop")
  click_button('deactivate')

end

Then(/^the bomb should explode$/) do
  expect(page).to have_content('Oops! You blew it!')
end

