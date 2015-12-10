Given(/^some bills$/) do
  FactoryGirl.create_list :bill, 20
end

When(/^I ask for bills from the API$/) do
  header 'Accept', 'application/json'
  get '/api/v1/bills'
end

Then(/^I should receive them with voting information$/) do
  bills_json = JSON last_response.body
  bills_json.should have(10).bill
end