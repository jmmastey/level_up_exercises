Given(/^I am on the home page$/) do
  visit '/'
end

Then(/^I should see a set activation code entry box with default value$/) do
  expect(page.find_by_id('activation_code')[:placeholder]).to eq('1234')
end

Then(/^I should see a set deactivation code entry box with default value$/) do
  expect(page.find_by_id('deactivation_code')[:placeholder]).to eq('0000')
end

Then(/^I should see a "(.+)" button$/) do |button_name|
  expect(has_button?(button_name)).to eq(true)
end

When(/^I set the activation and deactivation codes$/) do
  fill_in('activation_code', with: '1010')
  fill_in('deactivation_code', with: '2020')
  click_button("Boot")
end

Then(/^the bomb should be (.+) state$/) do |state|
  expect(page.find_by_id('bomb_state').text).to eq('The bomb is ' + state)
end

When(/^I click the "(.+)" button$/) do |button_name|
  click_button("#{button_name}")
end

Then(/^I should be on the bomb interface$/) do
  visit '/bomb'
end

Given(/^I am using the default codes$/) do
  visit '/'
  fill_in('activation_code', with: '1234')
  click_button("Boot")
end

Given(/^I am using the custom codes$/) do
  visit '/'
  fill_in('activation_code', with: '1010')
  click_button("Boot")
end

When(/^I enter the default activation code$/) do
  fill_in('user-code', with: '1234')
  click_button("Enter Code")
end

When(/^I enter the custom activation code$/) do
  fill_in('user-code', with: '1010')
  click_button("Enter Code")
end

Given(/^I have entered the activation and deactivation codes$/) do
  visit '/'
  fill_in('activation_code', with: '1010')
  fill_in('deactivation_code', with: '2020')
  click_button("Boot")
end

Given(/^the bomb is active$/) do
  fill_in('user-code', with: '1010')
  click_button("Enter Code")
  expect(page).to have_content("active")
end

When(/^I enter my correct deactivation code$/) do
  fill_in('user-code', with: '2020')
  click_button("Enter Code")
end

When(/^I enter my incorrecrt deactivation code$/) do
  fill_in('user-code', with: '1237')
  click_button("Enter Code")
end

When(/^I enter wrong deactivation code "(.*?)" 3 times$/) do |code|
  3.times do
    fill_in('user-code', with: code)
    click_button("Enter Code")
  end
end

Then(/^I should be on the exploaded page$/) do
  visit '/exploded'
end
