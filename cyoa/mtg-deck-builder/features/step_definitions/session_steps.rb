When(/^I log in$/) do
  visit('/login')
  fill_in 'session[username]', with: @user.username
  fill_in 'session[password]', with: '123456'
  click_button 'Go'
end

Then(/^I should see my user profile$/) do
  expect(page.find("#user-profile h2", text: @user.username))
end

Then(/^I should be logged in$/) do
  page.should have_selector('.btn', text: 'Log Out')
end

When(/^I log out$/) do
  click_link 'Log Out'
end

Then(/^I should be logged out$/) do
  page.should have_selector('.btn', text: 'Log In')
end
