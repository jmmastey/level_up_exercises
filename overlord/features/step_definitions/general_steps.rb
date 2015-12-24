When(/^I go to the home\s?page$/) do
  visit("/")
end

When(/^I go to the activation page$/) do
  visit("/activate")
end

Given(/^I go to the bomb active page$/) do
  visit("/active_bomb")
end

When(/^I click the "(.*?)" link$/) do |link|
  click_on(link)
end

When(/^I fill in "(.*?)" as the activation code$/) do |value|
	unless value == "N/A"
  		page.fill_in 'bomb-activation-code', :with => value
  	end
end

When(/^I fill in "(.*?)" as the deactivation code$/) do |value|
	unless value == "N/A"
  		page.fill_in 'bomb-deactivation-code', :with => value
  	end
end

Then(/^I should see "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

Then(/^I should see a "(.*?)" link$/) do |link|
  expect(page).to have_content(link)
end

Then(/^I should see a[n]? "(.*?)" input box$/) do |box_name|
	require 'pry'
	if CSS_MATCHERS[box_name]
		expect(page).to have_css("input#{CSS_MATCHERS[box_name]}")
	elsif CSS_MATCHERS.keys.include?(box_name)
		raise StandardError, "This element does not exist on the page"
	else
		raise StandardError, "Your tests don't contain a match for '#{box_name}'"
	end
end

Then(/^I should see a[n]? "(.*?)" button$/) do |button_text|
  expect(page).to have_css("button", {:text=>button_text})
end

Then(/^I should see a[n]? "(.*?)" submit button$/) do |button_id|
  expect(page).to have_css("input#{button_id}")
end

When(/^I press the "(.*?)" button$/) do |button_name|
  click_button(button_name)
end

Then(/^I fill in the following:$/) do |object, value|
  object = value
end

Then(/^I should be on the homepage$/) do
  visit("/")
end

CSS_MATCHERS = {
	#input boxes
	"Bomb activation code"=>"#bomb-activation-code",
	"Bomb deactivation code"=>"#bomb-deactivation-code",
	#links
	"Activate"=>"#activate",
	"Disarm"=>"#disarm"
}