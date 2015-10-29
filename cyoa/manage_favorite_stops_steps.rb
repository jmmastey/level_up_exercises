

Given(/^I have a MyCTApp account$/) do
  # user = create(:user)
  # visit("/signup")
  # fill_in("user_name", with: "Test Account")
  # fill_in("user_email", with: "dummy@example.com")
  # fill_in("user_password", with: "Testcase123")
  # fill_in("user_password_confirmation", with: "Testcase123")
  # click_button("Create my account")
  # delete("/logout")
  # delete("/login")
  # fill_in("session_email", with: "dummy@example.com")
  # fill_in("session_password", with: "Testcase123")
  # click_button("Log in")
  FactoryGirl.create(:user, name: "Example", email: "user.name@example.com", password_digest: User.digest('password'))
end

Given(/^I login$/) do
  visit("/login")
  fill_in("session_email", with: "user.name@example.com")
  fill_in("session_password", with: "password")
  click_button("Log in")
  @current_user = User.find_by_email("user.name@example.com")
end

When(/^I am on the homepage$/) do
  visit("/")
end

When(/^I select a bus route, direction, and stop$/) do
  select("(8) Halsted", from: "select_route", visible: false)
  select("Northbound", from: "select_direction", visible: false)
  select("Halsted & Chicago", from: "select_stop", visible: false)
end

When(/^I click the star icon$/) do
  using_wait_time 3 do
    click_on("fave_this")
  end
end

When(/^I have been notified that the route has been saved$/) do
  using_wait_time 10 do
    expect(page).to have_content('Route has been saved to your favorite routes.')
  end
end

When(/^I have been notified that the route has been removed$/) do
  expect(page).to have_content('Route has been removed from your favorite routes.')
end

# Find a select box by (label) name or id and assert the expected option is present
Then(/^I should see it in the list of Favorite Routes$/) do
  page.has_select?("favorite_route_select", :with_options => ["(8) Halsted & Chicago (Northbound)"]).should == true
end


When(/^I have a favorited a route$/) do
  select("(8) Halsted", from: "select_route", visible: false)
  select("Northbound", from: "select_direction", visible: false)
  select("Halsted & Chicago", from: "select_stop", visible: false)
  using_wait_time 3 do
    click_on("fave_this")
  end
  using_wait_time 3 do
    click_on("close_modal")
  end
end

When(/^I select a route from the list of Favorite Routes$/) do
  # find('#favorite_route_select').find(:xpath, 'option[]').select_option
end

Then(/^I should not see it in the list of Favorite Routes$/) do
  pending # express the regexp above with the code you wish you had
end
