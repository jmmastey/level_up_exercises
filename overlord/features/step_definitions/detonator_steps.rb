Given(/^the detonator is opened$/) do
  visit "/"
end

Given(/^the mode is set to "([^"]*)"$/) do |mode|
  step %Q{the detonator is opened}

  step %Q{I enter a valid code} if %w("armed" "configure").include?(mode)
  step %Q{I set the mode to "#{mode}"}
  step %Q{the mode should be set to "#{mode}"}
end

Given(/^the trigger is active$/) do
  step %Q{the mode is set to "armed"}
  step %Q{I enter a disarm code}
end

Given(/^the countdown is blank$/) do
  expect(page).to have_css(".clock", text: "--")
end

Given(/^the countdown is running$/) do
  step %Q{the trigger is active}
  step %Q{I press the trigger button}
end

When(/^I enter (?:a|an|the) (.*) code$/) do |type|
  code = case type
  when "valid" "1234"
  when "invalid" ""
  when "new" "9999"
  when "disarm" "0000"
  else type
  end

  fill_in("code", :with => code)
end

When(/^I set the mode to "([^"]*)"$/) do |mode|
  find(:css, "input[value=#{mode}]").set(true)
end

When(/^I press the (.*) button$/) do |field|
  find(:xpath, "//button[@name='#{field}']").click
end

Then(/^the (.*) button should( not)? be active$/) do |field, negate|
  disabled = " and @disabled='disabled'" unless negate.nil?
  attribute_selector = "[@name='#{field}'#{disabled}]"
  expect(page).to have_xpath("//button#{attribute_selector}")
end

Then(/^the mode should( not)? be set to "([^"]*)"$/) do |negate, mode|
  checked = " and @checked='checked'" if negate.nil?
  attribute_selector = "[@name='mode' and @value='#{mode}'#{checked}]"
  expect(page).to have_xpath("//input#{attribute_selector}")
end

Then(/^an error should be displayed$/) do
  expect(page).to have_css(".error_message")
end

Then(/^the countdown should be reset$/) do
  step %Q{the countdown is blank}
end

Then(/^the countdown should be running$/) do
  sample_a = find(:css, ".clock").text
  sample_b = find(:css, ".clock").text

  expect(sample_a).not_to eq(sample_b)
end

Then(/^the countdown should be accelerated$/) do
  # I want this noted in the scenario, but
  # haven't figured out best way to test this
  # in a robust fashion without compromising the
  # security of the countdown
  pending
end
