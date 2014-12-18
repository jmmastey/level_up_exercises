Given(/^a region exists with in-game ID (\d+) and name (.+)$/) do |in_game_id, name|
  FactoryGirl.create(:region, in_game_id: in_game_id, name: name)
end

Given(/^I have the following regions:$/) do |regions|
  regions.hashes.each do |region|
    FactoryGirl.create(:region, name: region[:name])
  end
end

When(/^I visit the regions page$/) do
  visit "/regions"
end
