 When(/^I enter the default deactivation code$/) do
 fill_in("deact_code", with: "0000")
 click_button("Submit deactivation code")
end

Then(/^the bomb should deactivate$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an incorrect activation code (\d+) time\(s\)$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the bomb should not deactivate$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the number of deactivation attempts remaining should be (\d+)$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I visit another page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the bomb should still be active$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^there should be (\d+) deactivation attempts left$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
