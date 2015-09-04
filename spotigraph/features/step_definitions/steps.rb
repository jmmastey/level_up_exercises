# Given ########################################################################

Given(/^I am on the homepage$/) do
  visit(root_path)
end

Given(/^I have logged on to the website$/) do
  visit('/users/sign_in')
  @email = Faker::Internet.email
  @password = Faker::Internet.password(8, 16)
  create_user(@email, @password)
  log_in(@email, @password)
end

# When  ########################################################################

When(/^I search for (.*?) at a depth (\d+)$/) do |artist, depth|
  fill_in('name', with: artist)
  fill_in('depth', with: depth.to_i)
  click_button('Submit')
end

When(/^I search with the artist field empty$/) do
  fill_in('name', with: '')
  fill_in('depth', with: '1')
  click_button('Submit')
end

When(/^I sign up with with appropriate credentials$/) do
  signup('example@email.com', 'password', 'password')
end

When(/^I sign up with a short password$/) do
  signup('example@email.com', 'a', 'a')
end

When(/^I use the forgot my password page with the wrong email$/) do
  click_link('Login')
  click_link('Forgot your password?')
  fill_in('user_email', with: 'example@email.com')
  click_button('Send me reset password instructions')
end

When(/^I sign up with mismatched passwords$/) do
  signup('example@email.com', 'password', 'password1')
end

When(/^I sign up with a bad email$/) do
  signup('asdfasfg', 'password', 'password')
end

When(/^I use the forgot my password page$/) do
  create_user('example@email.com', 'password')
  click_link('Login')
  click_link('Forgot your password?')
  fill_in('user_email', with: 'example@email.com')
  click_button('Send me reset password instructions')
end

When(/^I change my email to another valid email$/) do
  update_email(Faker::Internet.email)
end

When(/^I change my email to an invalid email$/) do
  update_email('asdf')
end

When(/^I change my password to a valid new password$/) do
  update_password(Faker::Internet.password(8, 16))
end

When(/^I change my password to something too short$/) do
  update_password('a')
end

When(/^I change my password but the passwords don't match$/) do
  edit_user_password('hello', 'world')
end

When(/^I change my email to something invalid$/) do
  update_email('hello')
end

When(/^I log (.*?)$/) do |direction|
  if direction == 'out'
    visit(root_path)
    click_link('Logout')
  elsif direction == 'in'
    email = Faker::Internet.email
    password = Faker::Internet.password(8, 16)
    visit('/users/sign_in')
    create_user(email, password)
    log_in(email, password)
  end
end

# Then ########################################################################

Then(/^I see a graph$/) do
  has_nodes = page.evaluate_script("typeof nodes !== 'undefined'")
  has_edges = page.evaluate_script("typeof edges !== 'undefined'")
  is_graph = has_nodes && has_edges
  expect(is_graph).to be true
end

Then(/^I see that (.*?) is not on spotify$/) do |artist|
  expect(page.html).to include(artist + ' could not be found')
end

Then(/^I see no error messages$/) do
  expect(page.html).not_to include('could not be found as a Spotify artist.')
end

Then(/^I see (.*?) as a related artist of (.*?)$/) do |to, from|
  expect(edge_exists?(from, to)).to be true
end

Then(/^I see no related artists$/) do
  edges_zero = page.evaluate_script('edges.length')
  expect(edges_zero).to equal 0
end

Then(/^I see the welcome page$/) do
  expect(page.html).to include('Welcome')
end

Then(/^I see a (.*?) link$/) do |arg1|
  expect(page.html).to include(arg1)
end

Then(/^I see a "(.*?)" (.*?) message$/) do |type, _|
  expect(page.html).to include(type << ' successfully')
end

Then(/^I see an error popup as soon as I type a depth above (\d+)$/) do |arg1|
  alert_text = get_alert_text_from do
    fill_in('depth', with: arg1)
  end
  expect(alert_text).to include('at depths greater than')
end

Then(/^I see an error$/) do
  expect(page.html).to include('error')
end

Then(/^I see an email confirmation$/) do
  expect(page.html).to include('email with instructions')
end
