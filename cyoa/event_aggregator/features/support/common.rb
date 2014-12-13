require "rspec/expectations"
require "uri"

URL_NICKNAMES =
{
  'about us' => '/about-us',
  'contact us' => '/contact-us',
  'privacy policy' => '/privacy-policy',
  'sign up' => '/users/sign_up',
  'home' => '/',
  'the customer service phone number' => EventAggregator.customer_service_telno,
  'the customer service e-mail address' => EventAggregator.customer_service_email,
}

AUTH_USERNAME = "foo@bar.baz"
AUTH_PASSWORD = "sweetpotato"
AUTH_FAIL_PASSWORD = "blahblah"

def url_by_nickname(url_nickname)
  URL_NICKNAMES[url_nickname.downcase]
end

def has_major_heading(heading_text)
  rexp = Regexp.new(heading_text)
  page.has_css?('h1,h2,h3,h4', text: rexp)
end
