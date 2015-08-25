Given(/^I go to search for users$/) do
  visit(friends_search_path)
end

Given(/^I have a friend$/) do
  step 'I receive a friend request'
  step 'I accept the friend request'
end

When(/^I search for an existing user$/) do
  @friend = create(:random_user)
  fill_in(:username, with: @friend.username)
  click_button('Search')
end

When(/^I search for a private user$/) do
  @friend = create(:private_user)
  fill_in(:username, with: @friend.username)
  click_button('Search')
end

When(/^I search for a non\-existant user$/) do
  @friend = build(:random_user)
  fill_in(:username, with: @friend.username)
  click_button('Search')
end

When(/^I send a friend request$/) do
  click_link('Send Friend Request')
end

When(/^I receive a friend request$/) do
  @friend = create(:random_user)
  switch_to_new_user(@friend)
  visit(friends_search_path)
  fill_in(:username, with: @user.username)
  click_button('Search')
  click_link('Send Friend Request')
  switch_users(@user)
end

When(/^I reject the friend request$/) do
  visit(profile_path)
  click_link('Reject')
end

When(/^I accept the friend request$/) do
  visit(profile_path)
  click_link('Accept')
end

When(/^I click on their username in my friends list$/) do
  visit(profile_path)
  click_link(@friend.username)
end

When(/^I search for my friend$/) do
  visit(friends_search_path)
  fill_in(:username, with: @friend.username)
end

Then(/^I expect to see an empty search result$/) do
  expect(find('.search-results ul')).not_to have_content(@friend.username)
  expect(page).to have_content('No results')
end

Then(/^I should see that user in my pending list$/) do
  expect(find('.friends-list')).to have_content("#{@friend.username} (pending)")
end

Then(/^the friend should not me in their pending list$/) do
  switch_users(@friend)
  visit(profile_path)
  expect(page).not_to have_content(@user.username)
end

Then(/^I should not see the request in my friends list$/) do
  expect(page).not_to have_content(@friend.username)
end

Then(/^I expect not to see the user in the search results$/) do
  expect(find('.search-results ul')).not_to have_content(@friend.username)
end

Then(/^I expect to see the user in the search results$/) do
  expect(find('.search-results ul')).to have_content(@friend.username)
end

Then(/^I should see the friend in my friends list$/) do
  expect(page).to have_content(@friend.username)
  expect(page).not_to have_content('Accept')
  expect(page).not_to have_content('Reject')
end

Then(/^the friend should see me in their friends list$/) do
  switch_users(@friend)
  visit(profile_path)
  expect(page).to have_content(@user.username)
  expect(page).not_to have_content('Accept')
  expect(page).not_to have_content('Reject')
  switch_users(@user)
end

Then(/^I should be on their profile page$/) do
  expect(page).to have_content(@friend.username)
  expect(find('.friends-list')).to have_content(@user.username)
end

Then(/^I should not see a pending request in my friends list$/) do
  visit(profile_path)
  expect(page).not_to have_content(@friend.username + ' (pending)')
end
