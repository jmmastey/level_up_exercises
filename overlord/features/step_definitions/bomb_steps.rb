Given(/^the bomb is booted with default config$/) do
  visit('/')
  click_button('Boot')
end

Given(/^the bomb is activated with default config$/) do
  fill_in('submit_activation_code', with: "1234")
  click_button('Activate')
end

When(/^I visit "([^"]*)"$/) do |url|
  visit(url)
end

When(/^I boot the bomb$/) do
  click_button('Boot')
end

When(/^I configure the activation code "([^"]*)"$/) do |code|
  fill_in('configure_activation_code', with: code)
end

When(/^I configure the deactivation code "([^"]*)"$/) do |code|
  fill_in('configure_deactivation_code', with: code)
end

When(/^I submit the activation code "([^"]*)"$/) do |code|
  fill_in('submit_activation_code', with: code)
  click_button('Activate')
end

When(/^I submit the deactivation code "([^"]*)"$/) do |code|
  fill_in('submit_deactivation_code', with: code)
  click_button('Deactivate')
end

Then(/^the bomb is "([^"]*)"$/) do |status|
  using_wait_time 10 do
    expect(find('.bomb_status').text).to eq(status)
  end
end

Then(/^I see "([^"]*)"$/) do |message|
  using_wait_time 10 do
    expect(page).to have_content(message)
  end
end

Then(/^there are (\d+) attempts left$/) do |num|
  using_wait_time 10 do
    expect(find('.attempts')).to have_content("#{num} attempts left")
  end
end
