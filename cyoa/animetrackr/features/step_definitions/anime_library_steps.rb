Given(/^I am currently watching (.+)$/) do |anime|
  click_link('Add Anime')
  fill_in(:title, with: anime)
  click_button('Search')
  first('.add-anime').click
  select('5', from: 'library_item_user_rating')
  choose('Public')
  choose('Currently Watching')
  click_button('Add')
end

When(/^I go to add an anime$/) do
  click_link('Add Anime')
end

When(/^search for '(.+)'$/) do |title|
  fill_in(:title, with: title)
  click_button('Search')
end

When(/^add the first result$/) do
  first('.add-anime').click
end

When(/^I go to search for an anime$/) do
  visit(anime_search_path)
end

When(/^I am done watching (.+)$/) do |anime|
  click_link(anime)
  choose('Done')
  click_button('Update')
end

When(/^I delete the anime (.+)$/) do |anime|
  click_link(anime)
  click_link('Delete')
end

When(/^I view my entire library$/) do
  visit(anime_library_path)
end

Then(/^I expect to have search result for '(.+)'$/) do |title|
  expect(page).to have_content('Search Results')
  expect(page).to have_content('Search Results for ' + title)
end

Then(/^the results should have a community rating$/) do
  expect(page).to have_content('Rating: ')
end

Then(/^I should be able to enter details for my library$/) do
  select('5', from: 'library_item_user_rating')
  choose('Public')
  choose('Done')
end

Then(/^click add$/) do
  click_button('Add')
end

Then(/^I should have an entry in my library$/) do
  visit(profile_path)
  expect(page).to have_content('Anime Library (1)')
end

Then(/^I should see (.+) in the done watching section$/) do |anime|
  expect(find('.library-overview .done-watching')).to have_content(anime)
end

Then(/^I should not see (.+) in my library$/) do |anime|
  expect(find('.library-overview')).not_to have_content(anime)
end

Then(/^I should see (.+) in my library$/) do |anime|
  expect(find('.library-overview')).to have_content(anime)
end

Then(/^I should not see (.+) in my full library$/) do |anime|
  expect(page).not_to have_content(anime)
end

Then(/^I should see (.+) in my full library$/) do |anime|
  expect(page).to have_content(anime)
end
