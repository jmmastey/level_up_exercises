Given(/^A bomb was booted$/) do
  visit "http://localhost:8080/mybomb"
  expect(page).to have_text("Bomb booted successfully")
end

When(/^Super villain is entering the activation code (\d+) for a bomb$/) do |code|
 fill_in "field-custom-activation-code", with:code
end

And(/^The bomb is inactive$/) do
  expect(page).to have_text("Bomb status: Inactive")
end

Then(/^the Super villain should see a message that the bomb was activated$/) do
  expect(page).to have_text("Bomb status: Activeed")
end

And(/^the bomb should be armed$/) do
  expect(page).to have_text("Bomb Armed")
end

And(/^the bomb should not be armed$/) do
  expect(page).to have_text("Bomb Armed").to.eq(false)
end


And(/^the Super villain should see a message that the bomb is still inactive$/) do
  expect(page).to have_text("Bomb status unchanged")
end