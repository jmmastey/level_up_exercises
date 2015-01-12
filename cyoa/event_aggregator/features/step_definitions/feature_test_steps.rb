Then /^I see a heading for "(.*)"/ do |heading_text|
  expect(has_major_heading(heading_text)).to be_truthy
end

Then /^I see a (?:(.*): )?link (?:for|to) ([^"].*)$/ do |link_type, target|
  selector = "a[href*=\"#{url_by_nickname(target)}\"]"
  selector = selector + "[href^=\"#{link_type}\"]" if link_type
  expect(has_css?(selector)).to be_truthy
end

Then /^I see a (?:(.*): )?link (?:for|to) "(.*)"$/ do |link_type, target|
  selector = "a"
  selector = selector + "[href^=\"#{link_type}\"]" if link_type
  text_pattern = Regexp.new(target, Regexp::IGNORECASE)
  links = all(selector, text: text_pattern)
  expect(links.any? { |link| link.visible? }).to be_truthy
end

When /^I click the link for "(.*)"$/ do |target|
  click_link(target);
end

Then /^I see the company mailing address$/ do
  expect(has_css?('#CompanyAddress')).to be_truthy
end

Then /^I see a command for "(.*)"$/ do |command|
  pattern = /#{command}/i
  expect(has_css?("#OperationMenu a", text: pattern)).to be_truthy
end

Then /^I see a feed highlight for "(.*)"$/ do |feed_name|
  expect(has_css?('h2.feed-highlight-title', text: feed_name)).to be_truthy
end

Then /^I see a feed category for "(.*)"$/ do |feed_category|
  expect(has_css?('a[role=menuitem]', text: feed_category)).to be_truthy
end

Then /^I see a login form$/ do
  expect(has_css?('#Login')).to be_truthy
end

Then /FIXME/ do
  "FIXME NOT DONE FIXME NOT DONE FIXME"
end

Then /^I see text "(.*?)"$/ do |text|
  match_expr = Regexp.new(text, Regexp::IGNORECASE)
  expect(has_css?('*', text: match_expr)).to be_truthy
end

When /^DEBUG$/ do
  save_and_open_page
end

When /^DUMP$/ do
  puts page.source
end
