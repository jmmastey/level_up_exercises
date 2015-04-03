Given(/^Bomb is active$/) do
  visit('/activate')
  fill_in('activate_code', with: '1234')
  click_button('Activate')
  visit('/deactivate')
  expect(page).to have_content('Bomb is active')
end

When(/^Super Villain enters correct deactivation code$/) do
  fill_in('deactivate_code', with: '0000')
end

When(/^Clicks Deactivate button$/) do
  click_button('Deactivate')
end

When(/^Super Villain is on deactivate page$/) do
  visit('/deactivate')
end

Then(/^He should see deactivate form$/) do
  expect(page).to have_content('Bomb is active')
  expect(page).to have_field('d2')
  expect(page).to have_field('deactivate_code')
  expect(page).to have_button('Deactivate')
end

When(/^Super Villain enters incorrect deactivation code$/) do
  fill_in('deactivate_code', with: '1111')
end

Then(/^Error message displayed$/) do
  expect(page).to have_content('Wrong deactivation code')
end

When(/^Super Villain enters incorrect deactivation code (\d+) times$/) do |count|
  count.to_i.times { submit_incorrect_deactivation_code }
end

Then(/^He should see explode page$/) do
  visit('/explode')
end

def submit_incorrect_deactivation_code
  fill_in('deactivate_code', with: '1111')
  click_button('Deactivate')
end
