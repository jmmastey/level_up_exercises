Given(/^I am on my profile page$/) do
  visit(profile_path)
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

Then(/^I should be redirected to the sign in page$/) do
  expect(current_path).to eq(new_user_session_path)
end
