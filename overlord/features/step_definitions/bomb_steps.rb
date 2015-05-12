 Given(/^I am on the bomb home page$/) do
   visit('/')
 end

 When(/^I boot the bomb$/) do
   click_button('Boot Bomb')
 end

Then(/^I am prompted to provide activation and deactivation codes$/) do
  expect(page).to have_css("input.activation_code")
  expect(page).to have_css("input.deactivation_code")
  expect(page).to have_button("Submit")
end



When(/^I submit valid codes$/) do
  fill_in('activation_code', with: "2468")
  fill_in('deactivation_code', with: "1357")
  click_button('Submit')
end

Then(/^I see the bomb has successfully booted$/) do
  expect(page).to have_css("input.activation_code")
  expect(page).to have_content('Successfully created.')
end

When(/^I submit invalid codes$/) do
  fill_in('activation_code', with: "abcd")
  fill_in('deactivation_code', with: "12345")
  click_button("Submit")
end

Then(/^I see that the bomb has not been created$/) do
  expect(page).to have_content('Not created.')
end

When(/^I submit the correct activation code$/) do
  fill_in('activation_code', with: "2468")
end

Then(/^I see the bomb timer start$/) do
  expect(page).to have_content('Time remaining:')
  expect(page).to have_css("input.deactivation_code")
end


