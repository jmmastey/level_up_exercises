require "rspec/expectations"
require "uri"

URL_NICKNAMES =
{
  'about us' => '/about-us.html',
  'contact us' => '/contact-us.html',
  'privacy policy' => '/privacy-policy.html',
  'sign up' => '/users/sign_up',
  'the customer service phone number' => EventAggregator.customer_service_telno,
  'the customer service e-mail address' => EventAggregator.customer_service_email,
}

def url_by_nickname(url_nickname)
  URL_NICKNAMES[url_nickname.downcase]
end

def has_major_heading(heading_text)
  rexp = Regexp.new(heading_text)
  page.has_css?('h1,h2,h3,h4', text: rexp)
end
