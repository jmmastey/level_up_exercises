Given(/^I am authenticated$/) do
  @user = build(:user)
  sign_up(@user.username, @user.email, @user.password)
end