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
