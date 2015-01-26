Given(/^I am not logged in$/) do
  # No Action - Not logged in by default after app start
end

Given(/^I am logged in$/) do
  @user = FactoryGirl.create(:user)
  visit new_user_session_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Log in"
end
