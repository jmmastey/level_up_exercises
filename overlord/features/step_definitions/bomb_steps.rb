def enter_code(code)
  steps <<-eos
    When I go to the bomb overview page
    And I fill in "code" with "#{code}"
    And I press "Submit"
  eos
end

def confirm_fields_with_state(state)
  step 'I go to the bomb overview page'

  find_field('code', state)
  find_button('Submit', state)
end

Given(/^the bomb has been activated$/) do
  step 'I enter the default activation code'
end

When /^I enter the default activation code$/ do
  enter_code(DEFAULT_ACTIVATION_CODE)
end

When /^I enter the custom activation code$/ do
  enter_code(CUSTOM_CODE)
end

When /^I enter the default deactivation code$/ do
  enter_code(DEFAULT_DEACTIVATION_CODE)
end

When /^I enter the custom deactivation code$/ do
  enter_code(CUSTOM_CODE)
end

When /^I enter the incorrect deactivation code (\d+) times$/ do |count|
  count.to_i.times.each { |_| enter_code('') }
end

When /^I enter an invalid (.*) code$/ do |code_type|
  steps <<-eos
    Given I am on the initialize page
    When I fill in "#{code_type}_code" with "#{CODE_WITH_INVALID_FORMAT}"
    And I press "Boot"
  eos
end

When /^I (.*) the activation$/ do |button|
  step "I press \"#{button.capitalize}\""
end

Then /^the bomb overview page should not be responsive$/ do
  confirm_fields_with_state(disabled: true)
end

Then /^the bomb overview page should not be changeable/ do
  # Phantomjs doesn't do a great job with readonly and disabled once items are marked as invisible.
  # This is as good as we're going to get to confirm that the javascript executed as expected.
  confirm_fields_with_state(visible: false)
end

Then /^the bomb should be in a (.*) state$/ do |state|
  steps <<-eos
    When I go to the bomb overview page
    Then I should see "#{state}" within ".status"
  eos
end

Then /^I should see a "([^"]*)" error$/ do |message|
  page.should have_selector('.error', text: /#{message}/i)
end
