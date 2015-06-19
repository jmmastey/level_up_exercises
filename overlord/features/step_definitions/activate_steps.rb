Given(/^I am on the activate page$/) do
  visit "/"
  click_button('Boot')
  expect(page).to have_content('booted')
end

When(/^I enter (\d+)$/) do |code|
  fill_in('code', with: code)
  click_button('Activate')
end

Then(/^I see the bomb is active$/) do
  expect(page).to have_content('active')
end

Given(/^The bomb is booted$/) do
  visit "/"
  click_button('Boot')
  expect(page).to have_content('booted')
end

When(/^I submit the wrong activation code (\d+)$/) do |code|
  fill_in('code', with: code)
  click_button('Activate')
end

Then(/^I see a wrong code error message$/) do
  expect(page).to have_content('Wrong code')
end
