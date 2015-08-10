Given(/^I am authenticated$/) do
  @user = build(:user)
  sign_up(@user.username, @user.email, @user.password)
end

When(/^I add a new anime (.+)$/) do |anime|
  step "I am currently watching #{anime}"
end

When(/^I change the status of (.+) to (.+)$/) do |anime, status|
  visit(profile_path)
  click_link(anime)
  choose(status)
  click_button('Update')
end

Then(/^I should see my activity feed saying I added (.+)$/) do |anime|
  visit(profile_path)
  expect(page).to have_content("Added #{anime}")
end

Then(/^I should see my activity feed saying that I am (.+) watching (.+)$/) do |anime, status|
  status.downcase!
  status += ' watching' if status.eql?('done')
  expect(page).to have_content("#{status} #{anime}")
end
