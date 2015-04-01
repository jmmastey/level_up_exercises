INVALID_EMAIL ||= "invalid@nope.com"
INVALID_PASSWORD ||= "_invalid_"
VALID_PASSWORD ||= "password"
VALID_NAME ||= "John Doe"
VALID_EMAIL ||= "jdoe@example.com"

INVALID_REPEAT_INTERVAL ||= 0
INVALID_MIN_RATING ||= -1.0
VALID_REPEAT_INTERVAL ||= 5 
VALID_MIN_RATING ||= 5.0 

PASSWORD ||= "password"

def create_and_login_user
  if page.driver.respond_to?(:block_unknown_urls)
    page.driver.block_unknown_urls
  end 

  FactoryGirl.create(:user, password: PASSWORD)
  user = User.first
  visit("/login")
  fill_in("session_email", with: user.email)
  fill_in("session_password", with: PASSWORD)
  click_button("login_btn")
end

def create_venue(count)
  count.times { |_| FactoryGirl.create(:venue) }
  # Wait for records to get written to the db
  loop do
    sleep(1)
    break if Venue.all.length == count
  end
end

Given(/^I am on the (.*?) page$/) do |path|
  page.driver.browser.clear_cookies
  if path == "home"
    visit('/')
  else
    visit("/#{path}")
  end
end

