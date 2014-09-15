Given(/^I have booted a bomb with the default codes$/) do
  visit("/")
  click_on("Boot")
end

Given(/^the bomb is not active$/) do
  expect(find(".activation_status")).to have_content("inactive")
end

When(/^I enter the code (\d+)$/) do |code|
  fill_in(:code, with: code)
end

Then(/^I should see the confirmation message$/) do
  expect(find(".message")).to have_content("confirm")
end

When(/^I confirm the code$/) do
  click_on("Confirm")
end

Then(/^the bomb should be activated$/) do
  expect(find(".activation_status")).to have_content("active")
end

Then(/^I should see an "(.*?)" error$/) do |error|
  expect(page).to have_content(error)
end

Then(/^the number of remaining disarm attempts should be set to (\d+)$/) do |attempts|
  expect(page).to have_content("#{attempts} attempts until detonation")
end
