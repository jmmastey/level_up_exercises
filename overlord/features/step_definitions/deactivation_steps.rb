Given(/^the bomb is booted with default codes$/) do
  visit("/")
  click_on("Boot")
end

Given(/^the bomb is active$/) do
  enter_code_on_keypad(1234)
  enter_code_on_keypad(0400)
  expect(find(".activation_status")).to have_content("ACTIVE")
end

Then(/^the bomb should be inactive$/) do
  expect(find(".activation_status")).to have_content("INACTIVE")
end

Then(/^the number of remaining disarm attempts should be (\d+)$/) do |attempts|
  expect(page).to have_content("#{attempts} attempts until detonation")
end

Given(/^(\d+) failed attempts have been made to disarm the bomb$/) do |attempts|
  attempts = attempts.to_i
  attempts.times do
    enter_code_on_keypad(5678)
  end
end

Then(/^the bomb should explode$/) do
  expect(page).to have_selector(".explosion")
end

