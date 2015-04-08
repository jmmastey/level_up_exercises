When(/^I click go$/) do
  page.find('.form-control.btn.btn-primary').click
end

When(/^I click keys$/) do
  page.find('.keys-button').click
end

When(/^I click clicks$/) do
  page.find('.clicks-button').click
end

When(/^I click download$/) do
  page.find('.download-button').click
end

When(/^I click upload$/) do
  page.find('.upload-button').click
end

When(/^I click uptime$/) do
  page.find('.uptime-button').click
end
