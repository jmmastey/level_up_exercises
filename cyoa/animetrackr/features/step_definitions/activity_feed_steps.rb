Given(/^I am authenticated$/) do
  @user = build(:user)
  sign_up(@user.username, @user.email, @user.password)
end

When(/^I add a new anime (.+)$/) do |anime|
  click_link('Add Anime')
  fill_in(:title, with: anime)
  click_button('Search')
  first('.add-anime').click
  select('5', from: 'library_item_user_rating')
  choose('Public')
  choose('Wishlist')
  click_button('Add')
end

When(/^I change the status of (.+) to (.+)$/) do |anime, status|
  status += ' Watching' if status.eql?('Currently')
  visit(profile_path)
  click_link(anime)
  choose(status)
  click_button('Update')
end

Then(/^I should see my activity feed saying I added (.+)$/) do |anime|
  visit(profile_path)
  expect(page).to have_content("Added #{anime}")
end

Then(/^I should see my activity feed saying that I am Done watching (.+)$/) do |anime|
  expect(page).to have_content("Done watching #{anime}")
end

Then(/^I should see my activity feed saying that I am Currently watching (.+)$/) do |anime|
  expect(page).to have_content("Currently watching #{anime}")
end
