Given(/^I am on my profile page$/) do
  visit(profile_path)
  expect(current_path).to eq(profile_path)
  expect(page).to have_title('Profile')
end

Then(/^I should see my gravatar$/) do
  expect(find('.avatar')[:src]).to have_content('https://www.gravatar.com/avatar/')
end

Then(/^I should see my username$/) do
  user = build(:user)
  expect(find('.profile-overview')).to have_content(user.username)
end

Then(/^I should see when I joined$/) do
  join_date_regex = /Member Since: \d{2}-\d{2}-\d{4}/
  expect(page.text).to match(join_date_regex)
end
