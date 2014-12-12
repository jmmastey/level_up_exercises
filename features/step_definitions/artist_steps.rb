Given(/^I am on the artists page$/) do
  visit artists_path
end

Given(/^I have (\d+) artists$/) do |arg1|
  artist_1 = create(:artist, first_name: "Claude",  last_name: "Monet")
  artist_2 = create(:artist, first_name: "Edouard", last_name: "Manet")
  artist_3 = create(:artist, first_name: "Vincent", last_name: "Van Gogh")
  artist_4 = create(:artist, first_name: "Pablo",   last_name: "Picasso")
  artist_5 = create(:artist, first_name: "Edward",  last_name: "Hopper")
end

Given(/^I am on a page for an artist$/) do
  artist = create(:artist, first_name: "Andy",  last_name: "Warhol")
  visit artist_path(artist)
end

When(/^I click (.+) Artist$/) do |action|
  click_link("#{action} Artist")
end

When(/^I create an invalid artist$/) do
  click_link("New Artist")
  fill_in("First Name", with: "")
  fill_in("Last Name", with: "")
  click_button("Create Artist")
end

When(/^I update the last name to Painter$/) do
  fill_in("Last Name", with: "Painter")
  click_button("Update Artist")
end

When(/^I create a new artist: Henri Matisse$/) do
  click_link("New Artist")
  fill_in("First Name", with: "Henri")
  fill_in("Last Name", with: "Matisse")
  click_button("Create Artist")
end

When(/^I edit an artist: (.+)$/) do |artist|
  click_link(artist)
  click_link("Edit Artist")
end

When(/^I delete (.+)$/) do |artist|
  click_link(artist)
  click_link("Delete Artist")
end

When(/^I edit an artist with invalid data: (.+)$/) do |artist|
  click_link(artist)
  click_link("Edit Artist")
  fill_in("First Name", with: "")
  fill_in("Last Name", with: "")
  click_button("Update Artist")
end

Then(/^I should not see (.+) on the Artists page$/) do |artist|
  expect(current_path).to eq(artists_path)
  expect(page).not_to have_content(artist)
end

Then(/^I should see the artist: (.+)$/) do |artist|
  expect(page).to have_content(artist)
end

Then(/^I should see details for the artist: Monet$/) do
  expect(page).to have_content 'Claude Monet'
  expect(page).to have_content 'French'
  expect(page).to have_content 'A founding member of the Impressionist movement in the late 1800s'
end

Then(/^I should be on the artists index$/) do
  expect(current_path).to eq(artists_path)
end

Then(/^I should be on the page for (.+)$/) do |artist|
  expect(page).to have_css('h1', text: artist)
end

Then(/^I should see all 5 artists$/) do
  expect(page).to have_content("Monet")
  expect(page).to have_content("Manet")
  expect(page).to have_content("Van Gogh")
  expect(page).to have_content("Picasso")
  expect(page).to have_content("Hopper")
end

Then(/^I should see validation errors$/) do
  expect(page).to have_content("The artist could not be saved.")
  expect(page).to have_content("Please correct the 2 errors below:")
  expect(page).to have_content("First name can't be blank.")
  expect(page).to have_content("Last name can't be blank.")
end

Then(/^I should see a message confirming the artist was (.+)$/) do |action|
  expect(page).to have_content("The artist was successfully #{action}.")
end

Then(/^I should see a thumbnail image$/) do
  url = "http://static1.artsy.net/artist_images/52f6bdda4a04f5d504f69b03/1/four_thirds.jpg"
  expect(page).to have_selector("img[src='#{url}']")
end

