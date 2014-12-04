Then(/^I should see "(.*)"$/) do |content|
  expect(page).to have_content(content)
end

Then(/^I should see "(.*)" link$/) do |content|
  expect(page).to have_selector(:link, content)
end
