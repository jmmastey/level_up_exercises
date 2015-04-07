Then(/^I should see a chart with data in it$/) do
  expect(page).to have_content(',')
end

Then(/^I should see the keys chart$/) do
  expect(page).to have_selector('.keys.chart.chart-active')
end

Then(/^I should see the clicks chart$/) do
  expect(page).to have_selector('.clicks.chart.chart-active')
end

Then(/^I should see the download chart$/) do
  expect(page).to have_selector('.download.chart.chart-active')
end

Then(/^I should see the upload chart$/) do
  expect(page).to have_selector('.upload.chart.chart-active')
end

Then(/^I should see the uptime chart$/) do
  expect(page).to have_selector('.uptime.chart.chart-active')
end
