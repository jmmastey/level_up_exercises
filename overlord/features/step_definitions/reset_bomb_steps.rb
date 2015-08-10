Given(/^the bomb arming code is configured$/) do
  expect(page).to have_content('Enter New Bomb Arming Code:')
end
