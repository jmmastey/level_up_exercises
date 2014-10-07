require "net/http"
require "rspec"
require "vcr"

Given(/^the web service domain is "([^"]*?)"$/) do |domain|
  @domain = domain
end

Given(/^the path for (?:[A-Za-z]+) is "([^"]*?)"$/) do |path|
  @path = path
end

When(/^I send a POST request to (?:[A-Za-z]+) with the params:$/) do |params|
  param_rows = params.rows_hash.map do |key, value|
    split_value = value.split(",").map(&:strip)
    [key, split_value]
  end
  param_rows = Hash[param_rows]

  response = VCR.use_cassette(@cassette_name) do
    http = Net::HTTP.new(@domain)
    request = Net::HTTP::Post.new(@path)
    request.set_form_data(param_rows)

    http.request(request)
  end

  @status = response.code
  @response_data = response.body
end

Then(/^the request should (not)?\s?be successful$/) do |negative|
  if negative.present?
    expect(@status).not_to be "200"
  else
    expect(@status).to be "200"
  end
end

Then(/^the XML response should (not)?\s?have "([^"]+)"$/) do |negative, xpath|
  if negative
    expect(@response_data).not_to have_xpath(xpath)
  else
    expect(@response_data).to have_xpath(xpath)
  end
end

Then(/^the XML response should (not)?\s?have "([^"]+)" with "([^"]+)" attribute set to "([^"]+)"$/) do |negative, xpath, attr_name, value|
  xpath += "[@#{attr_name}='#{value}']"

  if negative
    expect(@response_data).not_to have_xpath(xpath)
  else
    expect(@response_data).to have_xpath(xpath)
  end
end

Then(/^the XML response should (not)?\s?have "([^"]+)" with "([^"]+)" attribute not set to "([^"]+)"$/) do |negative, xpath, attr_name, value|
  xpath += "[@#{attr_name}!='#{value}']"

  if negative
    expect(@response_data).not_to have_xpath(xpath)
  else
    expect(@response_data).to have_xpath(xpath)
  end
end

Then(/^the XML response should (not)?\s?have "([^"]+)" with text "((?:[^"]|\\")+)"$/) do |negative, xpath, text|
  if negative
    expect(@response_data).not_to have_xpath(xpath).with_text(text)
  else
    expect(@response_data).to have_xpath(xpath).with_text(text)
  end
end

Then(/^the XML response should (not)?\s?have "([^"]+)" without text "((?:[^"]|\\")+)"$/) do |negative, xpath, text|
  if negative
    expect(@response_data).not_to have_xpath(xpath).without_text(text)
  else
    expect(@response_data).to have_xpath(xpath).without_text(text)
  end
end
