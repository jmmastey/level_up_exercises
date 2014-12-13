Given /^I am visiting the "(.*)" page$/ do |url_nickname|
  visit(url_by_nickname(url_nickname))
end

Then /^I see a heading for "(.*)"/ do |heading_text|
  expect(has_major_heading(heading_text)).to be_truthy
end

Then /^I see a (?:(.*): )?link to "?(.*)"?$/ do |link_type, target|
  selector = "a[href*=\"#{url_by_nickname(target)}\"]"
  selector = selector + "[href^=\"#{link_type}\"]" if link_type
  expect(has_css?(selector)).to be_truthy
end

Then /^I see the company mailing address$/ do
  expect(has_css?('#CompanyAddress')).to be_truthy
end

Then /^I see a menu for "(.*)"$/ do |menu_title|
  expect(has_css?('.dropdown-toggle', text: menu_title)).to be_truthy
end

Then /^I see a menu link (?:for|to) "(.*)"$/ do |menu_link|
  selector = "li.menu a[href*=\"#{url_by_nickname(menu_link)}\"]"
  puts "SELECTOR: #{selector}"
  expect(has_css?(selector)).to be_truthy
end

Given /^I (fail to )?authenticate/ do |fail_auth|
  visit("/")
  #puts "PAGE #{page.source}"
  fill_in('user[email]', with: AUTH_USERNAME)
  fill_in('user[password]', with: fail_auth ? AUTH_FAIL_PASSWORD : AUTH_PASSWORD)
  click_button('Log in')
end

Given /^I am an (un(?:authenticated)) user visiting the "(.*)" page$/ do |authstate, page|
  step "I authenticate" if authstate == "authenticated"
  step "I am visiting the \"#{page}\" page"
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
  raise "FIXME NOT DONE FIXME NOT DONE FIXME"
end
