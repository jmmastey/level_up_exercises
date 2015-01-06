credentials = { email: 'abc@xyz.com', password: 'AbcXyZ01@'}

def log_in(credentials)
  fill_in 'user[email]', with: credentials[:email]
  fill_in 'user[password]', with: credentials[:password]
  click_button 'Log in'
end

Given /^I exist as a user$/ do
  @user = User.create(credentials)
end

Given /^I am not logged in$/ do
  clear_cookies()
end

When /^I log in with valid credentials$/ do
  log_in(credentials)
end

Then /^I should be logged in$/ do
  within('.top-bar') do
    expect(page).not_to have_link('Log in')
    expect(page).not_to have_link('Sign up')
    expect(page).to have_link('Log out')
    expect(page).to have_content(@user.email)
  end

end

Then /^I should not be logged in$/ do
  within('.top-bar') do
    expect(page).to have_link('Log in')
    expect(page).to have_link('Sign up')
    expect(page).not_to have_link('Log out')
    expect(page).not_to have_content(@user.email)
  end
end

When /^I log in with invalid credentials$/ do
  log_in(credentials.merge(password: "#{credentials[:password]}00"))
end
