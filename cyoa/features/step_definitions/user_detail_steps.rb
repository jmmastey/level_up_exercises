Then(/^I should see both country flags$/) do
  expect(page).to have_selector('.flag-left.flag.flag-fi')
  expect(page).to have_selector('.flag-right.flag.flag-us')
end

Then(/^I should see both team names$/) do
  left_team_name = page.find('.team-name-left')
  expect(left_team_name.text).to eq('#Team.Quakenet')

  right_team_name = page.find('.team-name-right')
  expect(right_team_name.text).to eq('420_BLAZE_IT')
end

Then(/^I should see both team key counts$/) do
  left_team_keys = page.find('.team-keys-left')
  expect(left_team_keys.text).to include(',')

  right_team_keys = page.find('.team-keys-right')
  expect(right_team_keys.text).to include(',')
end

Then(/^I should see both team click counts$/) do
  left_team_clicks = page.find('.team-clicks-left')
  expect(left_team_clicks.text).to include(',')

  right_team_clicks = page.find('.team-clicks-right')
  expect(right_team_clicks.text).to include(',')
end

Then(/^I should see both team download counts$/) do
  left_team_download = page.find('.team-download-left')
  expect(left_team_download.text).to include(',')

  right_team_download = page.find('.team-download-right')
  expect(right_team_download.text).to include(',')
end

Then(/^I should see both team upload counts$/) do
  left_team_upload = page.find('.team-upload-left')
  expect(left_team_upload.text).to include(',')

  right_team_upload = page.find('.team-upload-right')
  expect(right_team_upload.text).to include(',')
end

Then(/^I should see both team uptime counts$/) do
  left_team_uptime = page.find('.team-uptime-left')
  expect(left_team_uptime.text).to include(',')

  right_team_uptime = page.find('.team-uptime-right')
  expect(right_team_uptime.text).to include(',')
end

