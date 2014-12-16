Given(/^a region exists with in-game ID (\d+) and name (.+)$/) do |in_game_id, name|
  FactoryGirl.create(:region, in_game_id: in_game_id, name: name)
end

When(/^I visit the regions page$/) do
  visit "/regions"
end
