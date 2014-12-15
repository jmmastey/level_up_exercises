Given(/^I have a registered user "(.*)"$/) do |username|
  visit('/users/sign_up')
  params = user_creation_params(username)
  params.each_pair do |field, value|
    fill_in("user[#{field}]", with: value)
  end
  fill_in("user[password_confirmation]", with: params['password'])
  click_button('Sign up')
end

Given /^I (fail to )?authenticate as "(.*)"/ do |fail_auth, username|
  visit("/")
  params = user_creation_params(username)
  fill_in('user[email]', with: params['email'])
  fill_in('user[password]',
          with: fail_auth.nil? ? params['password '] : 'garbage')
  click_button('Log in')
end

Given /^I am an (un(?:authenticated)) user visiting the "(.*)" page$/ do |authstate, page|
  step "I authenticate" if authstate == "authenticated"
  step "I am visiting the \"#{page}\" page"
end
