When(/^I enter application url in the browser$/) do
  visit('https://be-a-critique.herokuapp.com/')
end

Then(/^I see the home page$/) do
	expect(page).to have_link('Home') 
  expect(page).to have_link('About')
  expect(page).to have_link('News')
end

Then(/^I see a link to log in$/) do
	expect(page).to have_link('Log in')
end

Then(/^I see welcome message$/) do
	expect(page).to have_content('Welcome to Critique')
end

Then(/^I see a link to sign up$/) do
	expect(page).to have_link('Sign Up to Write A Review')
end

When(/^I log in$/) do
	click_link('Log in')
	fill_in('user_email', with: 'ckhadilkar@enova.com') 
	fill_in('user_password', with: 'ckhadilkar123')
	click_button('Log in')
end

Given(/^I am on home page$/) do
  visit('https://be-a-critique.herokuapp.com/')
end
	