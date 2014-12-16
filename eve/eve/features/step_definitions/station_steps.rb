Given(/^a station exists with in-game ID (\d+) and name (.+)$/) do |in_game_id, name|
  FactoryGirl.create(:station, in_game_id: in_game_id, name: name)
end

When(/^I visit the stations page$/) do
  visit "/stations"
end
