When(/^I click the "([^"]+)" link$/) do |link|
  click_link(link)
end

Then(/^I see the message "([^"]+)"$/) do |message|
  expect(page).to have_content(message)
end
