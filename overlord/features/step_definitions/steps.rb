Given(/^I am on ([^"]*) of the bomb$/) do |arg1|
  visit path_to(arg1)
end

Given(/^I specified my ([^"]*) code as ([^"]*)$/) do |type, value|
  visit path_to("the starting page")
  fill_in(type, with: value)
  click_button("Submit")
end

Given(/^I activated the bomb with the user's activation code$/) do
  visit path_to("the starting page")
  fill_in("activation", with: "1111")
  click_button("Submit")
  fill_in("activation", with: "1111")
  click_button("Activate")
end

Given(/^I activated the bomb with the user's deactivation code$/) do
  visit path_to("the starting page")
  fill_in("deactivation", with: "8675")
  click_button("Submit")
  fill_in("activation", with: "1234")
  click_button("Activate")
end

Given(/^I activated the bomb with the default codes$/) do
  visit path_to("the starting page")
  click_button("Submit")
  fill_in("activation", with: "1234")
  click_button("Activate")
end

Given(/^I unsuccessfully deactivated the bomb ([^"]*) times$/) do |num|
  num.to_i.times { click_button("Deactivate") }
end

Given(/^I try to load ([^"]*) of the bomb$/) do |page|
  visit path_to(page)
end

Given(/^I specified my activation code as "([^"]*)" and my deactivation code as "([^"]*)"$/) do |activation, deactivation|
  visit path_to("the starting page")
  fill_in("activation", with: activation)
  fill_in("deactivation", with: deactivation)
  click_button("Submit")
end

When(/^I click the "([^"]*)" button$/) do |button|
  click_button(button)
end

When(/^I create a new bomb$/) do
  visit path_to("the starting page")
  click_button("Submit")
end

When(/^I try the default activation code$/) do
  fill_in("activation", with: '1234')
  click_button("Activate")
end

When(/^I try to activate the bomb with the code ([^"]*)$/) do |arg1|
  fill_in("activation", with: arg1)
  click_button("Activate")
end

When(/^I try to deactivate the bomb with the user's code$/) do
  fill_in("deactivation", with: "8675")
  click_button("Deactivate")
end

When(/^I try to deactivate the bomb with the default code$/) do
  fill_in("deactivation", with: "0000")
  click_button("Deactivate")
end

Then(/^The page should say "([^"]*)"$/) do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then(/^I should be on (.+)$/) do |name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(name)
  else
    assert_equal path_to(name), current_path
  end
end
