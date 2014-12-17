Given /^the bomb should be inactive$/ do
  expect(page.find_by_id('status').text).to eq('Inactive')
end

Given /^the bomb should be active$/ do
  expect(page.find_by_id('status').text).to eq('Active')
end

When /^I enter the correct codes and submit$/ do
  fill_in('code', with: 1234)
  click_on('Destroy')
end

When /^I enter the incorrect codes and submit$/ do
  fill_in('code', with: 'wrong')
  click_on('Destroy')
end

Then /^warning should appear$/ do
  # save_and_open_page
  expect(page).to have_content("Failed")
end

Given(/^I enter new codes into change form$/) do
  fill_in('new_activate', with: 5555)
  fill_in('new_deactivate', with: 8888)
  click_on('Change Code')
end

Given(/^I enter new code into code activation form$/) do
  fill_in('code', with: 5555)
  click_on('Destroy')
end

When(/^I enter the incorrect codes three times$/) do
  3.times {
    fill_in('code', with: 6666)
    click_on('Destroy')
  }
end

Then(/^the bomb should explode$/) do
  expect(page).to have_content("BOOOOOOOOM")
end

Then(/^I enter new code into deactivation form$/)  do
  fill_in('defuse', with: 8888)
  click_on('Destroy')
end

Then(/^I enter original deactivation code$/) do
  fill_in('defuse', with: 4321)
  click_on('Destroy')
end

