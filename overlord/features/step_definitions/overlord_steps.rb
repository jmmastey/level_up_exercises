Given(/^I am on the bomb page$/) do
  visit '/'
end

Then(/^"([^"]*)" should be focused$/) do |id|
  expect(page.evaluate_script('document.activeElement.id')).to eq(id)
end
