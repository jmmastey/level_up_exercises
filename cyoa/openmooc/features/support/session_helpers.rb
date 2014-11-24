require 'warden'

include Warden::Test::Helpers

Before('@LoggedIn') do |_scenario|
  @session_user ||= FactoryGirl.create(:registered_user)
  login_as(@session_user, scope: :user)
  Warden.test_mode!
end

After('@LoggedIn') do |_scenario|
  logout(:user)
  Warden.test_reset!
end
