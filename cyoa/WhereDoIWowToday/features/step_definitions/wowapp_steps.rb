VALID_NAME = "Testcharacter"
REALMS = ["Argent Dawn", "Earthen Ring"]
VALID_REALM = REALMS[1]
ZONES = %w(Ashenvale Duskwood Westfall)
DEFAULT_ZONE = "Duskwood"

Given(/^I am on the (.*) page$/) do |page|
  stub_request(:any, /us.api.battle.net/)
  if page.eql?("character selection")
    REALMS.each do |realm_name|
      FactoryGirl.create(:realm, name: realm_name)
    end
  end
  visit path_to(page)
end

Given(/^there are multiple zones$/) do
  ZONES.each do |name|
      FactoryGirl.create(:category, name: name, blizzard_type: 'zone')
  end
end

Given(/^a zone with (\d+) uncompleted quests?$/) do |count|
  @test_character = FactoryGirl.create(:character)
  count.to_i.times do
    FactoryGirl.create(:character_zone_activity, :quest,
                       character: @test_character, category_name: DEFAULT_ZONE)
  end
end

Given(/^a zone with (\d+) uncompleted achievements$/) do |count|
  @test_character = FactoryGirl.create(:character)
  count.to_i.times do
    FactoryGirl.create(:character_zone_activity, :achievement,
                       character: @test_character)
  end
end

Given(/^a zone with (\d+) uncompleted objective restricted to the other faction$/) do |count|
  @test_character = FactoryGirl.create(:character, blizzard_faction_id_num: "1")
  count.to_i.times do
    FactoryGirl.create(:character_zone_activity, activity_faction_id: "2",
                       character: @test_character, category_name: DEFAULT_ZONE)
  end
end

Given(/^a zone with (\d+) quests? not completed by my character$/) do |count|
  @test_character = FactoryGirl.create(:character)
  count.to_i.times do
    FactoryGirl.create(:character_zone_activity, :quest,
                       character: @test_character, category_name: DEFAULT_ZONE)
  end
end

Given(/^(\d+) quests? not completed by a different character$/) do |count|
  other_character = FactoryGirl.create(:character)
  count.to_i.times do
    FactoryGirl.create(:character_zone_activity, :quest,
                       character: other_character, category_name: DEFAULT_ZONE)
  end
end

Given(/^a zone with (\d+) achievement not completed by my character$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^(\d+) achievements not completed by a different character$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^(\d+) objectives$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^(\d+) hidden objectives? and (\d+) visible objectives?$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^an empty todo list$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^a todo list with (\d+) objectives?$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^the blizzard API is unavailable$/) do
  stub_request(:any, /us.api.battle.net/).to_return(body: nil, status: 404)
  REALMS.each do |realm_name|
    FactoryGirl.create(:realm, name: realm_name, updated_at: 1.month.ago)
  end
  visit path_to("character selection")
end

When(/^I submit a valid character name and a valid realm$/) do
  FactoryGirl.create(:character, name: VALID_NAME, realm: VALID_REALM)
  fill_in("Name", with: VALID_NAME)
  select(VALID_REALM, from: "Realm")
  click_button("Submit")
end

When(/^I submit a valid but lowercase character name and a valid realm$/) do
  FactoryGirl.create(:character, name: VALID_NAME, realm: VALID_REALM)
  fill_in("Name", with: VALID_NAME.downcase)
  select(VALID_REALM, from: "Realm")
  click_button("Submit")
end

When(/^I submit an invalid combination of name and realm$/) do
  FactoryGirl.create(:character, name: VALID_NAME, realm: VALID_REALM)
  fill_in("Name", with: "xxxxxxxx")
  select(VALID_REALM, from: "Realm")
  click_button("Submit")
end

When(/^I request information for my character$/) do
  @test_character ||= FactoryGirl.create(:character)
  visit "/characters/#{@test_character.id}"
end

When(/^I click the zone name in the zone summaries$/) do
  REALMS.each do |realm_name|
    FactoryGirl.create(:realm, name: realm_name)
  end
  visit "/"
  FactoryGirl.create(:character, name: VALID_NAME, realm: VALID_REALM)
  fill_in("Name", with: VALID_NAME)
  select(VALID_REALM, from: "Realm")
  click_button("Submit")
  click_link(DEFAULT_ZONE)
end

When(/^I visit the zone details page$/) do
  zone = Category.find_by(name: DEFAULT_ZONE) || FactoryGirl.create(
           :category, name: DEFAULT_ZONE)
  visit("/categories/#{zone.id}?character=#{@test_character.id}")
end

When(/^I hide (\d+) objective$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I show all objectives$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I add (\d+) objective to the todo list$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I move the last objective to the beginning of the todo list$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I remove (\d+) objective from the todo list$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the realm selector should contain all of the realms$/) do
  known = Realm.all.map &:name
  listed = page.find("select").all("option").map &:value
  expect(listed).to match_array(known)
end

Then(/^I should be on the character page for that character$/) do
  realm = VALID_REALM.gsub("\s", '-')
  step "I should see \"#{VALID_NAME}\""
  step "I should see \"#{VALID_REALM}\""
end

Then(/^I should see a row for each zone$/) do
  ZONES.each { |zone| step "I should see \"#{zone}\"" }
end

Then(/^the zone's row should specify (\d+) ([a-z]+)$/) do |count, type|
  actual = page.find_by_id("#{DEFAULT_ZONE}_#{type}").text
  expect(actual).to eq(count)
end

Then(/^I should see the zone's details$/) do
  step "I should see \"#{DEFAULT_ZONE}\""
  step "I should see \"Uncompleted quests\""
  step "I should see \"Uncompleted achievements\""
end

Then(/^I should see (\d+) objectives?$/) do |count|
  page.assert_selector('li', :visible => true, :count => count.to_i)
end

Then(/^I should see the removed objective$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the todo list should contain (\d+) objectives?$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the new objective should be at the end of the todo list$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the moved objective should be at the beginning of the todo list$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the unmoved objects should retain their relative order$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the (.*) data is refreshed$/) do |data_type|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the (.*) data is not refreshed$/) do |data_type|
  pending # Write code here that turns the phrase above into concrete actions
end
