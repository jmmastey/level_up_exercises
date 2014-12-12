require "rspec/expectations"
require "uri"

URL_NICKNAMES =
{
  'about us' => '/about-us.html',
  'contact us' => '/contact-us.html'
}

LINK_NICKNAMES =
{
  'the customer service phone number' => EventAggregator.customer_service_telno,
  'the customer service e-mail address' => EventAggregator.customer_service_email,
}

def url_by_nickname(url_nickname)
  URL_NICKNAMES[url_nickname.downcase]
end

def has_major_heading(heading_text)
  rexp = Regexp.new(heading_text)
  page.has_css?('h1', text: rexp) || page.has_css?('h2', text: rexp)
end

def link_target_by_nickname(link_nickname)
  puts "link for #{link_nickname} is #{LINK_NICKNAMES[link_nickname]}"
  LINK_NICKNAMES[link_nickname]
end
