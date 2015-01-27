Given(/^I am on the weather page$/) do
  visit home_index_path
end

Then(/^I can see the weather for the next (\d+) hours$/) do |number_of_hours|
  pending # express the regexp above with the code you wish you had
end

Then(/^I can see the daily weather summary for the next week$/) do
  pending # express the regexp above with the code you wish you had
end