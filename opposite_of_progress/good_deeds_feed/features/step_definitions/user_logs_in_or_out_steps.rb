Given(/^I am at the user log in page$/) do
  visit("/login")
end

Given(/^aa user exists and is logged in$/) do
  user = FactoryGirl.create(:user)
  visit("/login/")
  fill_in("Email", with: user.email)
  fill_in("Password", with: user.password)
  click_button("Log in")
  expect(page).to have_selector(".user_info")
end

Given(/^a user account exists$/) do
  @user = FactoryGirl.create(:user)
end

Given(/^the legislator is in the user's favorites$/) do
  visit("/login/")
  fill_in("Email", with: @user.email)
  fill_in("Password", with: @user.password)
  click_button("Log in")
  visit("/legislators/1")
  click_button("Add to favorites")
end

When(/^I submit valid login credentials$/) do
  fill_in("Email", with: @user.email)
  fill_in("Password", with: @user.password)
  click_button("Log in")
end

Then(/^I am logged in to my account and see my account details$/) do
  expect(page).to have_selector(".user_info")
end

Then(/^I see my favorite legislators$/) do
  expect(page).to have_selector(".favorites")
end

Then(/^I see links to delete my favorite legislators$/) do
  expect(page).to have_selector("#favorite-1", text: /delete/i)
end

When(/^I submit an incorrect password$/) do
  fill_in("Email", with: @user.email)
  fill_in("Password", with: Faker::Lorem.word)
  click_button("Log in")
end

Then(/^I see a log in error$/) do
  expect(page).to have_selector('[class="alert alert-danger"]')
end

Then(/^I am not logged in to my account$/) do
  expect(page).to have_selector("#login_form")
end

When(/^I submit an incorrect username$/) do
  fill_in("Email", with: Faker::Lorem.word)
  fill_in("Password", with: @user.password)
  click_button("Log in")
end

When(/^I try to log in without entering a username\/password$/) do
  click_button("Log in")
end

Given(/^I have logged in to my account$/) do
  fill_in("Email", with: @user.email)
  fill_in("Password", with: @user.password)
  click_button("Log in")
end

Given(/^I log out$/) do
  click_link("Log out")
end
