Given /^I am visiting the "(.*)" page$/ do |url_nickname|
  visit(url_by_nickname(url_nickname))
end

Then /^I see a heading for "(.*)"/ do |heading_text|
  expect(has_major_heading(heading_text)).to be_truthy
end

Then /^I see an input for "(.*)"/ do |input_nickname|
  selector = "input\##{id_by_nickname(input_nickname)}"
  expect(has_css?(selector)).to be_truthy
end

Then /^I see a "(.*)" button$/ do |button_label|
  expect(has_css?("input[value*=\"#{button_label}\"]")).to be_truthy
end

When /^I press the "(.*)" button$/ do |button_label|
save_and_open_page
  click_button(button_label)
save_and_open_page
end

Then /^I see a (?:(.*): )?link (?:for|to) "?(.*)"?$/ do |link_type, target|
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
  expect(has_css?(selector)).to be_truthy
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

Then /^I see the "(.*)" page$/ do |page_name|
  expect(current_url).to match(/#{url_by_nickname(page_name)}/)
end

Then /^I see text "(.*?)"$/ do |text|
  expect(has_css?('*', text: Regexp.new("#{text}"))).to be_truthy
end

Given /^I leave the "(.*)" (?:input|field) blank$/ do |input_name|
  find_field(input_name).value = ""
end

