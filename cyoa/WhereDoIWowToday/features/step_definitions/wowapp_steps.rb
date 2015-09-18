VALID_NAME = "Testcharacter"
REALMS = ["Argent Dawn", "Earthen Ring"]
VALID_REALM = REALMS[1]
ZONES = %w(Ashenvale Duskwood Westfall)
DEFAULT_ZONE = "Duskwood"
OTHER_ZONE = "Westfall"

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
  stub_request(:any, /us.api.battle.net/)
  ZONES.each do |name|
    FactoryGirl.create(:category, name: name, blizzard_type: 'zone')
  end
end

Given(/^a zone with (\d+) uncompleted quests?$/) do |count|
  @test_character = FactoryGirl.create(:character)
  count.to_i.times do
    FactoryGirl.create(:activity, :quest, character: @test_character,
                       category_name: DEFAULT_ZONE)
  end
  @quest = Quest.all.first
end

Given(/^a zone with (\d+) uncompleted quest restricted to the other faction$/) do |count|
  @test_character = FactoryGirl.create(:character, blizzard_faction_id_num: "1")
  count.to_i.times do
    FactoryGirl.create(:activity, activity_faction_id: "2",
                       character: @test_character, category_name: DEFAULT_ZONE)
  end
  @quest = Quest.all.first
end

Given(/^a zone with (\d+) quests? not completed by my character$/) do |count|
  @test_character = FactoryGirl.create(:character)
  count.to_i.times do
    FactoryGirl.create(:activity, :quest, character: @test_character,
                       category_name: DEFAULT_ZONE)
  end
  @quest = Quest.all.first
end

Given(/^(\d+) quests? not completed by a different character$/) do |count|
  other_character = FactoryGirl.create(:character)
  count.to_i.times do
    FactoryGirl.create(:activity, :quest, character: other_character,
                       category_name: DEFAULT_ZONE)
  end
  @quest = Quest.all.first
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
  visit character_path(@test_character.id)
end

When(/^I click the zone name in the zone summaries$/) do
  FactoryGirl.create(:realm, name: VALID_REALM)
  visit root_path
  FactoryGirl.create(:character, name: VALID_NAME, realm: VALID_REALM)
  fill_in("Name", with: VALID_NAME)
  select(VALID_REALM, from: "Realm")
  click_button("Submit")
  click_link(DEFAULT_ZONE)
end

When(/^I visit the zone details page$/) do
  zone = Category.find_by(name: DEFAULT_ZONE) || FactoryGirl.create(
           :category, name: DEFAULT_ZONE)
  visit("#{category_path(zone.id)}?character=#{@test_character.id}")
end

When(/^I visit the quest details page$/) do
  visit(quest_path(@quest.id))
end

When(/^I click on the quest$/) do
  click_link(@quest.title)
end

When(/^I submit a new category for a quest$/) do
  @original_category = @quest.categories.first
  @added_category = Category.find_by(name: OTHER_ZONE) || FactoryGirl.create(
                      :category, name: OTHER_ZONE)
  visit(edit_quest_path(@quest.id))
  select(OTHER_ZONE, from: "category")
  click_button("Update quest")
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
  known = Realm.all.map(&:name)
  listed = page.find("select").all("option").map(&:value)
  expect(listed).to match_array(known)
end

Then(/^I should see the character's details$/) do
  expect(page).to have_content("#{VALID_NAME}")
  expect(page).to have_content("#{VALID_REALM}")
  expect(page).not_to have_content("does not exist")
end

Then(/^I should see a row for each zone$/) do
  ZONES.each { |zone| expect(page).to have_content("#{zone}") }
end

Then(/^the zone's row should specify (\d+) ([a-z]+)$/) do |count, type|
  actual = page.find_by_id("#{DEFAULT_ZONE}_#{type}").text
  expect(actual).to eq(count)
end

Then(/^I should see the zone's details$/) do
    expect(page).to have_content("#{DEFAULT_ZONE}")
    expect(page).to have_content("Uncompleted quests")
end

Then(/^I should see the quest's details$/) do
  expect(page).to have_content("#{@quest.title}")
  expect(page).to have_content("#{@quest.blizzard_id_num}")
  expect(page).to have_content("Required level")
  expect(page).to have_content("Level")
  @quest.categories.each do |category|
    expect(page).to have_content(category.name)
  end
end

Then(/^I should see the new category$/) do
  expect(page).to have_content(@added_category.name)
end

Then(/^I should see the old category$/) do
  expect(page).to have_content(@original_category.name)
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
