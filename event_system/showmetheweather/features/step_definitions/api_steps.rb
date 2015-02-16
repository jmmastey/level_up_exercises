require "json"

When(/^I access the the JSON URL for a forecast$/) do
  @response = get "/forecasts/show/60606.json"
end

Then(/^I receive the forecast in JSON$/) do
  expected_json = "{\"zip_code\":\"60606\",\"periods\":[{\"name\":\"Today\",\"start\":\"2015-02-02T12:00:00.000Z\",\"end\":\"2015-02-03T00:00:00.000Z\",\"predictions\":[{\"label\":\"High Temperature\",\"value\":\"100\"},{\"label\":\"Chance of Precipitation\",\"value\":\"50%\"},{\"label\":\"Conditions\",\"value\":\"Mostly Sunny\"}]},{\"name\":\"Tonight\",\"start\":\"2015-02-03T00:00:00.000Z\",\"end\":\"2015-02-03T12:00:00.000Z\",\"predictions\":[{\"label\":\"Low Temperature\",\"value\":\"75\"},{\"label\":\"Chance of Precipitation\",\"value\":\"25%\"},{\"label\":\"Conditions\",\"value\":\"Mostly Cloudy\"}]}]}"
  expected = JSON.parse(expected_json)
  expect(JSON.parse(@response.body)).to eq(expected)
end
