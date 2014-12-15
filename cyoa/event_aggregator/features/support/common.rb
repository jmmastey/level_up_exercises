require "rspec/expectations"
require "uri"

URL_NICKNAMES =
{
  'login' => '/users/sign_in',
  'about us' => '/about-us',
  'contact us' => '/contact-us',
  'privacy policy' => '/privacy-policy',
  'sign up' => '/users/sign_up',
  'home' => '/',
  'my feeds' => '/my-feeds',
  'the customer service phone number' => EventAggregator.customer_service_telno,
  'the customer service e-mail address' => EventAggregator.customer_service_email,
  'the login page' => '/users/sign_in',
}

AUTH_PASSWORD = "sweetpotato"
AUTH_FAIL_PASSWORD = "blahblah"

def url_by_nickname(url_nickname)
  URL_NICKNAMES[url_nickname.downcase]
end

def has_major_heading(heading_text)
  rexp = Regexp.new(heading_text)
  page.has_css?('h1,h2,h3,h4', text: rexp)
end

def user_password(username)
  username.reverse * 3
end

def user_creation_params(username)
  {
    'email' => "#{username.downcase}@test.me",
    'first_name' => username.capitalize,
    'last_name' => "#{username.reverse}sohn",
    'password' => user_password(username)
  }
end

