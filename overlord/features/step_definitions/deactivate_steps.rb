Given(/^I am on the activated bomb page$/) do
  visit "/"
  click_button('Boot')
  fill_in('code', with: 1234)
  click_button('Activate')
  expect(page).to have_content('active')
end

When(/^I input the correct deactivation code (\d+)$/) do |code|
  fill_in('code', with: code)
  click_button('Deactivate')
end

Then(/^I see the bomb deactivated message$/) do
  expect(page).to have_content('deactivated')
end

When(/^I input the wrong code (\d+)$/) do |code|
  fill_in('code', with: code)
  click_button('Deactivate')
end

Then(/^I see a bomb active message$/) do
  expect(page).to have_content('active')
end

When(/^I wait (\d+) seconds$/) do |seconds|
  sleep seconds.to_i
end

Then(/^the bomb blows up$/) do
  URI.parse(current_url).path == 'detonate'
end
