Given(/^a station exists with in-game ID (\d+) and name (.+)$/) do |in_game_id, name|
  FactoryGirl.create(:station, in_game_id: in_game_id, name: name)
end

Given(/^I have the following stations:$/) do |stations|
  stations.hashes.each do |station|
    FactoryGirl.create(:station, name: station[:name])
  end
end

Given(/^I am on the stations page$/) do
  visit stations_path
end

When(/^I visit the stations page$/) do
  visit stations_path
end

Then(/^I see (\d+) stations$/) do |count|
  expect(page).to have_css(".station", count: count)
end
