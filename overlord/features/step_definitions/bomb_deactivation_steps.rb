 require 'capybara/cucumber'
# Capybara.app = BombManager

Given(/^A bomb is active$/) do
  visit "http://localhost:8080/mybomb"
end

# When /I sign in/ do
#   within("#session") do
#     fill_in 'Email', :with => 'user@example.com'
#     fill_in 'Password', :with => 'password'
#   end
#   click_button 'Sign in'
# end

When(/^Super villain enters the deactivation code$/) do
  expect(page).to have_text("Bomb Inactive")
end

When(/^Super villain enters the deactivation code "([^"]*)"$/) do |code|
  fill_in "field-deactivation-code", :with => code
end

And(/^Super villain click the "([^"]*)" button$/) do |button_name|
  click_button button_name
end

Then(/^The bomb should deactivate$/) do
  expect(page).to have_text("Bomb Active").to eq false
end

And(/^The bomb clearly shows it is inactive$/) do
  expect(page).to have_text("Bomb Inactive")
end

And(/^An incorrect deactivation code was already entered incorrectly (\d+) times since the bomb was activated$/) do |current_count|
  expect(page).to have_text("failed attempts count:"+current_count)
end


Then(/^The should see a message that should say "([^"]*)"$/) do |msg|
  expect(page).to have_text(msg)
end

And(/^The bomb should explode$/) do
  expect(page).to have_text("extremly loud boom!")
end

And(/^All buttons should be disabled$/) do
  expect(page).to have_button('Go', disabled: true)
end

And(/^The bomb not explode$/) do
  pending
end

And(/^An incorrect deactivation code was entered (.*) since the bomb was activated$/) do |times|
  expect(page).to have_text("failed attempts count: "+times)
end

And(/^the Super villain should have attempts (.*)$/) do |left|
  expect(page).to have_text("tries left: "+left)
end
