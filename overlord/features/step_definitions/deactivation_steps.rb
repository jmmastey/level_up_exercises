Given(/^the bomb is booted with default codes$/) do
  visit("/")
  click_on("Boot")
end

Given(/^the bomb is active$/) do
  fill_in(:code, with: 1234)
  click_on("Enter")
  expect(find(".activation_status")).to have_content("active")
end

When(/^I enter the code (\d+)$/) do |code|
  fill_in(:code, with: code)
end

When(/^click Enter$/) do
  click_on("Enter")
end

Then(/^the bomb should be inactive$/) do
  expect(find(".activation_status")).to have_content("inactive")
end

Then(/^the number of remaining disarm attempts should be (\d+)$/) do |attempts|
  expect(page).to have_content("#{attempts} attempts until detonation")
end

Given(/^(\d+) failed attempts have been made to disarm the bomb$/) do |attempts|
  attempts.times do
    fill_in(:code, with: 5678)
    click_on("Enter")
  end
end

Then(/^the bomb should explode$/) do
  expect(page).to have_selector(".explosion")
end

