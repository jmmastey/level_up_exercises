Given(/^I visit the home page$/) do
  visit('/')
end

When(/^I do nothing$/) do
end

Then(/^the bomb should be off$/) do
  expect(find('.bomb-state').text.downcase).to eq('off')
end

When(/^I boot up the bomb$/) do
  find('.set-bomb').click
end

Then(/^the bomb should be on$/) do
  expect(find('.bomb-state').text.downcase).to eq('on')
end

When(/^I configure the activation code to be (\d+)$/) do |code|
  fill_in('activation_code', with: code)
end

When(/^I configure the deactivation code to be (\d+)$/) do |code|
  fill_in('deactivation_code', with: code)
end