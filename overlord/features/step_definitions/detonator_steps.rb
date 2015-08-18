Given(/^the bomb is (.*)ed$/) do |mode|
  visit "/"

  step %(I enter a valid code) if mode == "arm"
  step %(I #{mode} the bomb) unless mode == "boot"
end

Given(/^the trigger is active$/) do
  step %(the bomb is armed)
end

Given(/^the countdown is running$/) do
  step %(the trigger is active)
  step %(I press the trigger button)
end

Given(/^the wires are exposed$/) do
  step %(I open the wire panel)
end

Given(/^the bomb exploded$/) do
  step %(the bomb is booted)
  page.execute_script(%($(document).trigger('short')))
  sleep(3)
end

When(/^I enter (?:a|an|the) (.*) code$/) do |type|
  fill_in("code", with: valid_code) if type == "valid"
  fill_in("code", with: invalid_code) if type == "invalid"
  fill_in("code", with: disarm_code) if type == "disarm"
end

When(/^I (.*) the bomb$/) do |mode|
  button = find(:css, ".mode.#{mode}ed")
  button.click
end

When(/^I press the (.*) button$/) do |field|
  button = find(:css, "[name=#{field}]")
  button.click
end

When(/^I open the wire panel$/) do
  wires = find(:css, ".wires")
  wires.click
end

When(/^I cut a (.*) wire$/) do |type|
  wire_selector = disarm_wire if type.downcase == "disarming"
  wire_selector = detonate_wire if type.downcase == "detonating"

  first(:css, wire_selector).click
end

When(/^I cut all the disarming wires$/) do
  page.all(:css, "#{disarm_wire}.intact").each do
    first(:css, "#{disarm_wire}.intact").click
  end
  sleep(3)
end

When(/^the countdown ends$/) do
  step %(the bomb exploded)
end

Then(/^the (.*) button should( not)? be active$/) do |field, negate|
  button = find(:css, "[name=#{field}]")
  op = negate.nil? ? 'not_to' : 'to'
  expect(button).send(op, be_disabled)
end

Then(/^the bomb should( not)? be (.*)$/) do |negate, mode|
  checked = negate.nil? ? '' : " and @checked='checked'"
  expect(page).to have_xpath(
    %(//input[@name='mode' and @value='#{mode}'#{checked}]))
end

Then(/^an error should be displayed$/) do
  expect(page).to have_selector("#error", visible: true)
end

Then(/^the countdown should( not)? be running$/) do |negate|
  sleep(1)
  a = find(:css, "[name=clock]")
  a = a.value.to_f
  sleep(1)
  b = find(:css, "[name=clock]")
  b = b.value.to_f

  expect(a).to be > b if negate.nil?
  expect(a).to equal(b) unless negate.nil?
end

Then(/^the bomb should( not)? have exploded$/) do |negate|
  page.find("body")[:class].include?("exploded") == negate.nil?
end

Then(/^the wires should be exposed$/) do
  expect(page).to have_css(".wires .exposed")
  expect(page).not_to have_css(".wires .exposed.hidden")
end

Then(/^the interface should( not)? be disabled$/) do |negate|
  step %(the trigger button should not be active) if negate.nil?
  code = find(:css, "input[name=code]")
  op = negate.nil? ? 'to' : 'not_to'
  expect(code).send(op, be_disabled)
end
