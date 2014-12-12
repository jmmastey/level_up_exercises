Given /^The bomb should be inactive$/ do
  expect(page.find_by_id('status').text).to eq('Inactive')
end