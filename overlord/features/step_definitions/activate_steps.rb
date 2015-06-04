#Given(/^I am on the activate bomb page$/) do
#  visit "/"
#end

 
#When(/^Code (\d+) Entered$/) do |code|
#  @code = code 
#  end

#Then(/^I see the countdown start$/) do
#  expect(page).to have_content('Countdown')
#end


Given(/^I have an unbooted bomb$/) do
  visit "/"
end

When(/^I enter code (\d+)$/) do |code|
  fill_in('activate_code', with: code)
end

Then (/^I see the bomb is booted message$/) do
  expect(page).to have_content('booted')
end

#  Scenario: Boot bomb successfully
#    Given I have an unbooted bomb
#    When I enter code 1234
#    Then I see the bomb is booted message
