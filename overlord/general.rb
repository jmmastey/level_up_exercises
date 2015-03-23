
def submit
  find("input[value='Submit']").click
end

def content_check(text)
  expect(page).to have_content(text)
end

Given(/^I am on the home page$/) do
  visit '/config'
end

When(/^I use '(\d+)' as a act code, '(\d+)' as a deact code$/) do |act, deact|
  fill_in 'act', with: act
  fill_in 'deact', with: deact
  submit
end

When(/^I use the default codes$/) do
  submit
end

Then 'I land on the Activate page' do
  find(:xpath, "//td[contains(text(),'Activation Code')]")
  content_check('The Bomb is inactive')
end

When(/^I enter '(\d+)' to activate the bomb$/) do |act_code|
  fill_in 'activation', with: act_code
  submit
end

Then(/^My bomb is activated and I have '(\d+)' attempts to disarm$/) do |count|
  expect(page).to have_content("You have #{count} attempts")
end

When(/^I enter '(\d+)' as my deact code '(\d+)' times$/) do |de_act, times|
  1.upto(times.to_i) do
    fill_in 'de_code_in', with: de_act
    submit
  end
end

Then(/^The bomb is deactivated and I can config a new one$/) do
  content_check("Configure a bomb ")
end

Then(/^My bomb goes off and everyone dies$/) do
  content_check("KABOOM!")
end

When(/^I enter no code in the '([^"]*)' box$/) do |box|
  fill_in box, with: ''
  submit
end

Then(/^I see the alert box and I accept the alert$/) do
  page.driver.browser.switch_to.alert.accept
end

When(/^I enter '(.*?)' in the '(.*?)' box$/) do |code, box|
  fill_in box, with: code
end

Then(/^I have '(.*?)' in the '(.*?)' box$/) do |_code, box|
  content_check(box)
end

Then(/^the bomb status is '([^"]*)'$/) do |status|
  content_check(status)
end
