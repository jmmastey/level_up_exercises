# =============== OUTLINE =========================
When(/^I activate a bomb with (\d+)$/) do |arg1|
  fill_in "activation_code", :with => arg1
  click_button('Activate!')
end

When(/^I activate a bomb with "(.*?)"$/) do |arg1|
  fill_in "activation_code", :with => arg1
  click_button('Activate!')
end

Then(/^I expect to be warned that the bomb is "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

# =============== /OUTLINE =========================

Given(/^a bomb has been created$/) do
  visit('/')
  fill_in("create_activation_code", with: 1234)
  click_button('Create!')
end

Given(/^I'm on the inactive bomb page$/) do
end

When(/^I activate a bomb with a correct numeric code$/) do
  fill_in "activation_code", :with => 1234
  click_button('Activate!')
end

When(/^I activate a bomb with a correct string code$/) do
  fill_in "activation_code", :with => "1234"
  click_button('Activate!')
end

Then(/^I should be on a new page$/) do
  # This step was actually more for debugging...
  expect(current_path).to eq("/bomb/active")
end

When(/^I activate a bomb with an incorrect code$/) do
  fill_in "activation_code", :with => 9999
  click_button('Activate!')
end

When(/^I activate a bomb with no code$/) do
    click_button('Activate!')
end

When(/^I activate a bomb with non\-alphanumeric codes$/) do
  fill_in "activation_code", :with => "@#^#@#"
  click_button('Activate!')
end

Then(/^I expect to be warned that the bomb is active$/) do
  expect(page).to have_content("Bomb Status: ACTIVE")
end

Then(/^I expect to be warned that the bomb is not active$/) do
  expect(page).to have_content("Incorrect code - bomb not active")
end

