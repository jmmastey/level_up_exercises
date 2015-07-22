Given(/^I visit the home page$/) do
  visit('/')
end

When(/^I do nothing$/) do
end

When(/^I boot the bomb$/) do
  click_button('Boot')
end

Then(/^the bomb should be booted$/) do
  using_wait_time 10 do
    expect(find('.bomb_status').text).to eq("Booted up!")
  end
end

When(/^I configure the activation code "([^"]*)"$/) do |code|
  fill_in('configure_activation_code', with: code)
end

When(/^I configure the deactivation code "([^"]*)"$/) do |code|
  fill_in('configure_deactivation_code', with: code)
end

Then(/^the bomb should be off$/) do
  using_wait_time 10 do
    expect(find('.bomb_status').text).to eq("Off!")
  end
end

Given(/^the bomb is booted with default config$/) do
  visit('/')
  click_button('Boot')
end

Then(/^I see an configuration error message$/) do
  using_wait_time 10 do
    expect(page).to have_content("Invalid parameters")
  end
end

Then(/^I see an activation error message$/) do
  using_wait_time 10 do
    expect(page).to have_content("Wrong activation code")
  end
end

Then(/^I see a deactivation error message$/) do
  using_wait_time 10 do
    expect(page).to have_content("Wrong deactivation code")
  end
end

Then(/^there are (\d+) attempts left$/) do |num|
  using_wait_time 10 do
    expect(find('.attempts')).to have_content("#{num} attempts left")
  end
end

When(/^I submit the activation code "([^"]*)"$/) do |code|
  fill_in('submit_activation_code', with: code)
  click_button('Activate')
end

Then(/^the bomb is now activated$/) do
  expect(find('.bomb_status').text).to eq("Activated!")
end

Given(/^the bomb is activated with default config$/) do
  fill_in('submit_activation_code', with: "1234")
  click_button('Activate')
end

When(/^I submit the deactivation code "([^"]*)"$/) do |code|
  fill_in('submit_deactivation_code', with: code)
  click_button('Deactivate')
end

Then(/^the bomb should be deactivated$/) do
  expect(find('.bomb_status').text).to eq("Deactivated!")
end

Then(/^the bomb should explode$/) do
  expect(find('.bomb_status').text).to eq("Exploded!")
end
