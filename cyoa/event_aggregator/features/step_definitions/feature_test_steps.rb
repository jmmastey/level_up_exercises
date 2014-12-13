Given /^I am visiting the "(.*)" page$/ do |url_nickname|
  visit(url_by_nickname(url_nickname))
end

Then /^I see a heading for "(.*)"/ do |heading_text|
  expect(has_major_heading(heading_text)).to be_truthy
end

Then /^I see a link to "(.*)"$/ do |link_type, target|
  selector = "a[href*=\"#{url_by_nickname(target)}\"]"
  selector = selector + "[href^=\"#{link_type}\"]" if link_type
  expect(has_css?(selector)).to be_truthy
end

Then /^I see the company mailing address$/ do
  expect(has_css?('#CompanyAddress')).to be_truthy
end

Given /^I am authenticated/ do

end

Given /^I am an (un(?:authenticated)) user visiting the "(.*)" page$/ do |authstate, page|
  step "I am authenticated" if authstate == "authenticated"
  step "I am visiting the \"#{page}\" page"
end

Then /^I see a feed highlight for "(.*)"$/ do |feed_name|
  expect(has_css?('h2.feed-highlight-title', text: feed_name)).to be_truthy
end

Then /^I see a feed category for "(.*)"$/ do |feed_category|
  expect(has_css?('ul.category-list li', text: feed_category)).to be_truthy
end
