Given(/^Bomb is not booted$/) do
  true
end

When(/^Super Villain accesses config page$/) do
  visit '/configure'
end

Then(/^He should see configuration form$/) do
  expect(page).to have_field('activation_code')
  expect(page).to have_field('deactivation_code')
  expect(page).to have_button('Boot')
end

Given(/^Super Villain is on config page$/) do
  visit '/configure'
end

When(/^Super Villian clicks boot$/) do
  click_button('boot')
end

When(/^Super Villain enters activation code '0101'$/) do
  fill_in('activation_code', with: '0101')
end

When(/^He enters deactivation code '1010'$/) do
  fill_in('deactivation_code', with: '1010')
end

When(/^Clicks Boot$/) do
  click_button('boot')
end

Then(/^He should see activate page$/) do
  expect(page).to have_field('activate_code')
  expect(page).to have_button('Activate')
end

When(/^Super Villain enters invalid activation code$/) do
  fill_in('activation_code', with: 'abcd')
  click_button('boot')
end

When(/^Super Villain enters invalid deactivation code$/) do
  fill_in('deactivation_code', with: 'abcd')
  click_button('boot')
end

Then(/^He should see error message$/) do
  expect(page).to have_content('Invalid codes')
end
