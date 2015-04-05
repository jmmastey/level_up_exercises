When(/^I click the I'm going button$/) do
  click_button("add_history_btn")
end

Given(/^I have saved a recommendation$/) do
  create_venue(1)
  click_button("get_rec_btn")
  wait_for_ajax
  click_button("add_history_btn")
end

When(/^I visit the history page$/) do
  visit("/history")
end
