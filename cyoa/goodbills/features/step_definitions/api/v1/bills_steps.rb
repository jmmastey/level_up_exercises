Given(/^some bills$/) do
  FactoryGirl.create_list :bill, 20
end

When(/^I ask for bills from the API$/) do
  header 'Accept', 'application/json'
  get '/api/v1/bills'
end

Then(/^I should receive them with voting information$/) do
  bills_json = JSON last_response.body
  expect(bills_json.length).to eq(10)
  expect(bills_json[0]["official_title"]).to eq("title-1")
  expect(bills_json[0]["score"]).to eq("250.0")
end

When(/^I vote that I like one$/) do
  header 'Accept', 'application/json'
  put '/api/v1/bills/1', {:bill => {:vote => "like"}}
end

Then(/^my vote should be counted$/) do
  bills_json = JSON last_response.body
  expect(bills_json.length).to eq(10)
  expect(bills_json[0]["score"]).to eq("251.0")
end