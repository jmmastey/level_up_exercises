Given(/^there are no bombs$/) do
  http_delete '/bomb/delete'
  visit '/'
  expect(page).to have_content('No bomb created yet')
end

Given(/^there is a bomb$/) do
  visit '/'
  fill_in('activation_code', with: '1234')
  fill_in('deactivation_code', with: '2345')
  click_button('Create Bomb')
end

Given(/^I see the keypad$/) do
  expect(page).to have_css("#keypad")
end

Given(/^I click the activation button$/) do
  click_button('Activate')
end

Given(/^(?:I )?enter in the correct activation code$/) do
  click_button("1")
  click_button("2")
  click_button("3")
  click_button("4")
  expect(page).to have_content('1234')
  click_button("Confirm")
end

Given(/^I enter in the correct deactivation code$/) do
  click_button("2")
  click_button("3")
  click_button("4")
  click_button("5")
  expect(page).to have_content('2345')
end

Given(/^the status is ARMED$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I click the deactivation button$/) do
  click_button('Deactivate')
end

When(/^I create a bomb$/) do
end

When(/^enter an activation code$/) do
  fill_in('activation_code', with: '1234')
end

When(/^enter a deactivation code$/) do
  fill_in('deactivation_code', with: '2345')
end

When(/^press the create button$/) do
  click_button('Create Bomb')
end

When(/^I view my bomb$/) do
  visit '/'
end

When(/^I click the activate button$/) do
  click_button('Activate')
end

When(/^(?:I )?enter in the incorrect activation code$/) do
  click_button("9")
  click_button("9")
  click_button("9")
  click_button("9")
  expect(page).to have_content('9999')
  click_button("Confirm")
end

When(/^I enter in the incorrect deactivation code (\d+)$/) do |code|
  click_button(code[0])
  click_button(code[1])
  click_button(code[2])
  click_button(code[3])
  expect(page).to have_content(code)
  click_button("Confirm")
  page.accept_alert('Invalid code')
end

When(/^(?:I )?click the confirm button$/) do
  click_button('Confirm')
end

Then(/^there should be a bomb with a panel$/) do
  find_button('Activate')
  find_button('Deactivate')
end

Then(/^I expect to see the timer count down$/) do
  expect(page).not_to have_content('00:00')
  expect(page).not_to have_content('99:99')
end

Then(/^the status to equal ARMED$/) do
  expect(page).not_to have_content('INACTIVE')
  expect(page).not_to have_content('DEACTIVATED')
  expect(page).to have_content('ARMED')
end

Then(/^the status to equal INACTIVE$/) do
  expect(page).not_to have_content('ARMED')
  expect(page).not_to have_content('DEACTIVATED')
  expect(page).to have_content('INACTIVE')
end

Then(/^the status should be DEACTIVATED$/) do
  expect(page).not_to have_content('ARMED')
  expect(page).not_to have_content('INACTIVE')
  expect(page).to have_content('DEACTIVATED')
end

Then(/^I should see an invalid code error message$/) do
  page.accept_alert('Invalid code')
end

Then(/^there should be a bomb$/) do
  expect(page).not_to have_content('No bomb created yet')
  find_button('Activate')
  find_button('Deactivate')
end

Then(/^the status should be inactive$/) do
  expect(page).to have_content('INACTIVE')
end

Then(/^I should see the bomb explode$/) do
  expect(page).to have_css("#exploded")
  expect(page).not_to have_css("#bomb-panel")
end

Then(/^I should see the timer stop$/) do
  expect(page).to have_content('99:99')
end

Then(/^the activation button should not work$/) do
  click_button('Activate')
  expect(page).not_to have_css("#keypad")
  expect(page).not_to have_content('Confirm')
end

Then(/^the deactivation button should not work$/) do
  click_button('Deactivate')
  expect(page).not_to have_css("#keypad")
  expect(page).not_to have_content('Confirm')
end
