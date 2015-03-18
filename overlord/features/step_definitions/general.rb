Given(/^I am on the home page$/) do
  visit '/config'
end

When (/^I enter '(\d+)' and '(\d+)' into the bomb$/) do |act_code, deact_code|
  fill_in 'act', with: act_code
  fill_in 'deact', with: deact_code
  find(:xpath, "//input[@value='Submit']").click
end

When(/^I use the default codes$/) do
  find(:xpath, "//input[@value='Submit']").click
end

Then 'I land on the Activate page' do
  find(:xpath, "//td[contains(text(),'Activation Code')]")
  expect(page).to have_content('The Bomb is inactive')
end

When(/^I enter '(\d+)' to activate the bomb$/) do |act_code|
  fill_in 'activation', with: act_code
  find(:xpath, "//input[@value='Submit']").click
end

Then(/^My bomb is activiated and I have '(\d+)' attempts to disarm$/) do |count|
  expect(page).to have_content("You have #{count} attempts")
end

When(/^I enter '(\d+)' as my deactivation code$/) do |de_act|
  fill_in 'de_code_in', with: de_act
  find(:xpath, "//input[@value='Submit']").click
end

Then(/^I the bomb is deactivated and I can config a new one$/) do
  expect(page).to have_content("Configure a bomb ")
end

Then(/^My bomb goes off and everyone dies$/) do
  expect(page).to have_content("KABOOM!")
end

When(/^I enter no code in the '([^"]*)' box$/) do |box|
  fill_in box, with: ''
  find(:xpath, "//input[@value='Submit']").click
end

Then(/^I see the alert box and I accept the alert$/) do
  page.driver.browser.switch_to.alert.accept
end

When(/^I enter '(.*?)' in the '(.*?)' box$/) do |code, box|
  fill_in box, with: code
end

Then(/^I have '(.*?)' in the '(.*?)' box$/) do | _code, box|
  expect(page).to have_content(box)
end

Then(/^the bomb status is '([^"]*)'$/) do |status|
  expect(page).to have_content(status)
end
