require "rspec/expectations"

URL_NICKNAMES =
{
  'about us' => '/about-us.html',
}

def url_by_nickname(url_nickname)
  puts "XLATING '#{url_nickname}' TO '#{URL_NICKNAMES[url_nickname]}'"
  URL_NICKNAMES[url_nickname.downcase]
end

def has_major_heading(heading_text)
  rexp = Regexp.new(heading_text)
  page.has_css?('h1', text: rexp) || page.has_css?('h2', text: rexp)
end
