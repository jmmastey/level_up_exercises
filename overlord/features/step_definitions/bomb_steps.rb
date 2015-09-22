Given(/^I visit the homepage$/) do
  visit("/")
end

When(/^I enter the bomb activation code "([^"]*)"$/) do |code|
  fill_in("activeCode", with: code)
end

When(/^I enter the bomb deactivation code "([^"]*)"$/) do |code|
  fill_in("deactiveCode", with: code)
end

When(/^I deploy the bomb$/) do
  click_button('DEPLOY')
end

When(/^I click "([^"]*)"$/) do |button_text|
  click_button(button_text)
end

Then(/^I expect the bomb status to be "([^"]*)"$/) do |status|
  using_wait_time 10 do
    expect_bomb_status(status)
  end
end

Given(/^the bomb status is "([^"]*)"$/) do |status|
  using_wait_time 10 do
    expect_bomb_status(status)
  end
end


Given(/^I deployed a bomb with an activation code of "([^"]*)"$/) do |code|
  visit("/")
  fill_in("activeCode", with: code)
  fill_in("deactiveCode", with: "0000")
  click_button("DEPLOY")
  using_wait_time 10 do
    expect_bomb_status("ready for activation")
  end
end

When(/^I enter a activation code "([^"]*)" on the page$/) do |code|
  fill_in("activateCode", with: code)
end


Given(/^I deployed a bomb with a deactivation code of "([^"]*)"$/) do |code|
  visit("/")
  fill_in("activeCode", with: "1234")
  fill_in("deactiveCode", with: code)
  click_button("DEPLOY")
  using_wait_time 10 do
    expect_bomb_status("ready for activation")
  end
end

Given(/^I activated the bomb$/) do
  fill_in("activateCode", with: "1234")
  click_button("ACTIVATE")
end

When(/^I enter a deactivation code "([^"]*)" on the page$/) do |code|
  fill_in("deactiveCode", with: code)
end


Given(/^I deployed a bomb$/) do
  visit("/")
  fill_in("activeCode", with: "1234")
  fill_in("deactiveCode", with: "5678")
  click_button("DEPLOY")
  using_wait_time 10 do
    expect_bomb_status("ready for activation")
  end
end

When(/^I enter an incorrect deactivation code three times$/) do
  fill_in("deactiveCode", with: "1111")
  click_button("DEACTIVATE")
  using_wait_time 10 do
    expect(page).to have_content("Attempts Remaining: 2")
  end

  fill_in("deactiveCode", with: "1112")
  click_button("DEACTIVATE")
  using_wait_time 10 do
    expect(page).to have_content("Attempts Remaining: 1")
  end

  fill_in("deactiveCode", with: "1113")
  click_button("DEACTIVATE")
end

Then(/^the bomb is exploded$/) do
  expect(page).to have_content("Bomb Detonated")
end

def expect_bomb_status(status)
  expect(find("#_bombStatus").text).to eql(status)
end