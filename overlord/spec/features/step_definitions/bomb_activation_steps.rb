Given(/^I am in the home page$/) do
  visit '/'
  url = URI.parse(current_url).request_uri
  expect(url).to eq('/')
end

When(/^I hover on the Overlord image$/) do
  page.find('#overlord').trigger(:mouseover)
end

When(/^I click on the image$/) do
  page.find('#overlord').trigger(:click)
end

Then(/^I should be redirected to bomb activation page$/) do
  url = URI.parse(current_url).request_uri
  expect(url).to eq('/boot_device')
end
