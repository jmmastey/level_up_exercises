When(/^I click the "([^"]+)" link$/) do |link|
  click_link(link)
end

When(/^I click the "([^"]+)" button$/) do |text|
  click_button(text)
end

Then(/^I see the message "([^"]+)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I see (\d+) in the EVE ID column$/) do |id|
  expect(page).to have_css("tr td.field-in_game_id", text: id.to_s)
end

Then(/^I see "([^"]+)" in the name column$/) do |name|
  expect(page).to have_css("tr td.field-name", text: name)
end
