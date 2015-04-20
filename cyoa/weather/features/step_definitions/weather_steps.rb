Given(/^I am on the home page$/) do
  visit "/"
end

Given(/^I am not logged in$/) do
  expect(page).to have_link("Log in")
end

When(/^I click sign up$/) do
  click_link('Sign up now!')
end

Then(/^I should be taken to the sign up page$/) do
  expect(page.current_path).to eq '/signup'
end

When(/^I click log in$/) do
  click_link('Log in')
end

When(/^I enter a valid username$/) do
  FactoryGirl.create(:user)
  fill_in('Email', with: 'cthulu@rlyeh.com')
end

When(/^I enter a valid password$/) do
  fill_in('Password', with: 'password')
end

When(/^I click the log in button$/) do
  click_button('Log in')
end

Then(/^I should be logged in$/) do
  expect(page.current_path).to_not have_link("Log in")
end

Given(/^I am on the sign up page$/) do
    visit "/signup"
end

Given(/^I enter name as "(.*?)"$/) do |arg1|
    fill_in('Name', with: arg1)
end

Given(/^I enter email as "(.*?)"$/) do |arg1|
  fill_in('Email', with: arg1)
end

Given(/^I enter password as "(.*?)"$/) do |arg1|
  fill_in('Password', with: arg1)
end

Given(/^I enter password confirmation as "(.*?)"$/) do |arg1|
  fill_in('Password confirmation', with: arg1)
end

Given(/^I click create my account$/) do
    click_button('Create my account')
end

Then(/^I should be taken to the home page with a check your email message$/) do
  expect(page.current_path).to eq '/'
  #expect(flash[:success]).to be_present
end

Then(/^I should not be signed up$/) do
  expect(page.current_path).to eq '/users'
end

Given(/^I am logged in$/) do
    visit "/"
    FactoryGirl.create(:user)
    click_link('Log in')
    fill_in('Email', with: 'cthulu@rlyeh.com')
    fill_in('Password', with: 'password')
    click_button('Log in')
end

Then(/^I should be able to see the weeks weather$/) do
  expect(page).to have_content 'Weather'
end
