Given(/^I am on the bomb home page$/) do
  visit('/newbomb')
end

When(/^I submit valid codes$/) do
  fill_in('activation_code', with: "2468")
  fill_in('deactivation_code', with: "1357")
  click_button('Boot Bomb')
end

Then(/^I see the bomb has successfully booted$/) do
  expect(page).to have_css("input.activation_code")
  expect(page).to have_content('Bomb successfully created.')
end

When(/^I submit invalid codes$/) do
  fill_in('activation_code', with: "abcd")
  fill_in('deactivation_code', with: "12345")
  click_button("Boot Bomb")
end

Then(/^I see that the bomb has not been created$/) do
  expect(page).to have_content('Codes were not accepted.')
end

Given(/^I successfully boot the bomb$/) do
  visit('/newbomb')
  fill_in('activation_code', with: "2468")
  fill_in('deactivation_code', with: "1357")
  click_button('Boot Bomb')
end

When(/^I submit the correct activation code$/) do
  fill_in('activation_code', with: "2468")
  click_button('Submit')
end

Then(/^I see the bomb timer start$/) do
  expect(page).to have_content('Time remaining:')
  expect(page).to have_css("input.deactivation_code")
end

When(/^I submit incorrect activation code$/) do
  fill_in('activation_code', with: "2469")
  click_button('Submit')
end

When(/^I submit an invalid activation code$/) do
  fill_in('activation_code', with: "hellooooooooooooooooooooooooooo")
  click_button('Submit')
end

Then(/^I see an error message$/) do
  expect(page).to have_content("Incorrect activation code")
end

Then(/^I see a prompt to activate$/) do
  expect(page).to have_css("input.activation_code")
end

Given(/^I successfully boot and activate the bomb$/) do
  visit('/newbomb')
  fill_in('activation_code', with: "2468")
  fill_in('deactivation_code', with: "1357")
  click_button('Boot Bomb')
  fill_in('activation_code', with: "2468")
  click_button('Submit')
end

When(/^I submit the valid deactivation code$/) do
  fill_in('deactivation_code', with: "1357")
  click_button('Submit')
end

Then(/^I see the bomb has successfully deactivated$/) do
  expect(page).to have_content('Successful deactivation!')
end

When(/^I submit an invalid deactivation code$/) do
  fill_in('deactivation_code', with: "2468")
  click_button('Submit')
end

Then(/^I see the bomb has not deactivated$/) do
  expect(page).to have_content("attempt(s) remain")
end

When(/^I submit (\d+) invalid activation codes$/) do |num_attempts|
  num_attempts.to_i.times do
    fill_in('deactivation_code', with: "hello")
    click_button('Submit')
  end
end

Then(/^I see the bomb exploded$/) do
  expect(page).to have_content("The bomb went off")
end
