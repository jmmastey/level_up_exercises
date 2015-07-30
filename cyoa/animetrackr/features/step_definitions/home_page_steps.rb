Given(/^I am signed out$/) do
 visit(destroy_user_session_path)
end

When(/^I view the home page$/) do
  visit(root_path)
end

Then(/^I should see home title$/) do
  expect(page).to have_title('AnimeTrackr')
end

Then(/^there should be a link to sign in$/) do
  expect(find_link('Sign In')[:href]).to eq(new_user_session_path)
end

Then(/^there should be a link to sign up$/) do
  expect(find_link('Sign Up')[:href]).to eq(new_user_registration_path)
end

Given(/^I am signed in$/) do
  sign_in(USER[:email], USER[:password])
end

Then(/^I should be redirected to the profile page$/) do
  expect(current_path).to eq(profile_path)
  expect(page).to have_content('Your Profile')
end

Then(/^there should not be a link to sign in$/) do
  expect(page).not_to have_content('Sign In')
end

Then(/^there should not be a link to sign up$/) do
  expect(page).not_to have_content('Sign Up')
end

Then(/^there should be a link to sign out$/) do
  expect(page).to have_content('Sign Out')
end

Then(/^there should not be a link to sign out$/) do
  expect(page).not_to have_content('Sign Out')
end
