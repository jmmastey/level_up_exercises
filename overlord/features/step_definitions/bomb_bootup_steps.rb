# require 'capybara/cucumber'
#
#
# Given(/^I am booting a bomb$/) do
#   # visit "http://localhost:8080/mybomb/"
# end
#
# When(/^I am on the main page$/) do
#   # expect(page).to have_button('New', disabled: false)
# end
#
#
# And(/^I do not provide a custom activation code$/) do
#   # fill_in "field-custom-activation-code", with: ""
# end
#
# When(/^the bomb boots$/) do
#   # expect(page).to have_text("Bomb booted successfully")
# end
#
# Then(/^the bomb should not be activated$/) do
#   # expect(page).to have_text("Bomb status: Inactive")
# end
#
# And(/^the Super villain should see a message that a new bomb was created$/) do
#   # expect(page).to have_text("Bomb created successfully")
# end
#
# And(/^the bomb activation code should be set to (\d+)$/) do |code|
#   # expect(page).to have_text("Bomb activation code: " << code)
# end
#
# And(/^Super villain does provide a custom activation code "([^"]*)"$/) do |code|
#   # fill_in "field-custom-activation-code", with: code
# end
#
# And(/^the Super villain should see a message that a new bomb was not created$/) do
#   # expect(page).to have_text("Bomb was not created")
# end
#
# Given(/^Super villain has an already booted and activated the bomb$/) do
#   # visit "http://localhost:8080/mybomb"
#   # expect(page).to have_text("Bomb status: Inactive")
# end
#
# And(/^the bomb activation code should not change$/) do
#   # expect(page).to have_text("Bomb activation code: 9999").to eq false
# end
#
# When(/^Super villain does not enter a a custom deactivation code$/) do
#   # expect(page).to have_text("Bomb status: Inactive")
#   # fill_in "field-custom-deactivation-code", with: ""
# end
#
# # Then(/^the bomb deactivation code should be default to (\d+)$/) do |code|
# #   expect(page).to have_text("Bomb deactivation code: " + code)
# # end
#
# When(/^Super villain does enter a a custom deactivation code (\d+)$/) do |code|
#   # fill_in "field-custom-deactivation-code", with: code
# end
#
# Then(/^the bomb deactivation code should be set to (\d+)$/) do |code|
#   # expect(page).to have_text("Bomb deactivation code: " + code)
# end
#
# Given(/^A bomb is active$/) do
#   # visit "http://localhost:8080/mybomb/"
# end
#
# When(/^Super villain enters the deactivation code$/) do
#   # expect(page).to have_text("Bomb Inactive")
# end
#
# When(/^I apply the deactivation code"([^"]*)"$/) do |code|
#   # fill_in "field-deactivation-code", :with => code
# end
#
# And(/^Super villain click the "([^"]*)" button$/) do |button_name|
#   # click_button button_name
# end
#
# Then(/^The bomb should deactivate$/) do
#   # expect(page).to have_text("Bomb Active").to eq false
# end
#
# And(/^The bomb clearly shows it is inactive$/) do
#   # expect(page).to have_text("Bomb Inactive")
# end
#
# And(/^An incorrect deactivation code was already entered incorrectly (\d+) times since the bomb was activated$/) do |current_count|
#   # expect(page).to have_text("failed attempts count:"+current_count)
# end
#
#
# Then(/^The should see a message that should say "([^"]*)"$/) do |msg|
#   # expect(page).to have_text(msg)
# end
#
# And(/^The bomb should explode$/) do
#   # expect(page).to have_text("extremly loud boom!")
# end
#
# And(/^All buttons should be disabled$/) do
#   # expect(page).to have_button('Go', disabled: true)
# end
#
# And(/^The bomb should not explode$/) do
#   # expect(page).to have_button('Go', disabled: false)
# end
#
# And(/^An incorrect deactivation code was entered (.*) since the bomb was activated$/) do |times|
#   # expect(page).to have_text("failed attempts count: "+times)
# end
#
# And(/^the Super villain should have attempts (.*)$/) do |left|
#   # expect(page).to have_text("tries left: "+left)
# end
#
# Given(/^A bomb was booted$/) do
#   # visit "http://localhost:8080/mybomb/"
#   # expect(page).to have_text("Bomb booted successfully")
#   #   should move into the 'setup code'
# end
#
# And(/^The bomb is inactive$/) do
#   # expect(page).to have_text("Bomb status: Inactive")
# end
#
# Then(/^the Super villain should see a message that the bomb was activated$/) do
#   # expect(page).to have_text("Bomb status: Activeed")
# end
#
# And(/^the bomb should be armed$/) do
#   # expect(page).to have_text("Bomb Armed")
# end
#
# And(/^the bomb should not be armed$/) do
#   # expect(page).to have_text("Bomb Armed").to.eq(false)
# end
#
# And(/^the Super villain should see a message that the bomb is still inactive$/) do
#   # expect(page).to have_text("Bomb status unchanged")
# end
#
# When(/^I enter the activation code (\d+) for a bomb$/) do |code|
#   # fill_in "field-custom-activation-code", with:code
# end
#
# And(/^I activate a bomb$/) do
#   # click_button "Acivate Bomb"
# end
#
# Then(/^I see a message that the bomb was activated$/) do
#   pending
# end
#
# And(/^I see a message that the bomb is still inactive$/) do
#   pending
# end
#
# And(/^I create a new bomb$/) do
#   pending
# end
#
# And(/^I see a message that a new bomb was created$/) do
#   pending
# end
#
# And(/^I provide a custom activation code "([^"]*)"$/) do |arg|
#   pending
# end
#
# And(/^I see a message that a new bomb was not created$/) do
#   pending
# end
#
# Given(/^I already booted and activated the bomb$/) do
#   pending
# end
#
# When(/^I apply the deactivation code "([^"]*)"$/) do |arg|
#   pending
# end
#
# Then(/^The see a message that should say "([^"]*)"$/) do |arg|
#   pending
# end
#
# And(/^I see that I have (\d+) attempts left$/) do |arg|
#   pending
# end
#
# When(/^I do not enter a custom deactivation code$/) do
#   pending
# end
#
# When(/^I enter a custom deactivation code (\d+)$/) do
#   pending
# end
#
# Then(/^The see a message that should say deactivation failed$/) do
#   pending
# end
#
# When(/^I do not enter a a custom deactivation code$/) do
#   pending
# end
#
# When(/^I enter a a custom deactivation code (\d+)$/) do
#   pending
# end