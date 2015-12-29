When(/^I submit an activation and deactivation code$/) do
  step 'I fill in "activation-code" with "4321"'
  step 'I fill in "deactivation-code" with "1234"'
  step 'I press "boot-bomb"'
end

Then(/^the bomb should be booted$/) do
  step 'I should see "Time:"'
  step 'the "time" field should contain ""'
end

Then(/^the bomb should be activated$/) do
  step 'I should see the element id "alarm"'
  step 'I should see ":active"'
end

Then(/^the bomb should be deactivated$/) do
  step 'I should see ":inactive"'
end

When(/^I activate the bomb$/) do
  step 'I fill in "activation-code" with "4321"'
  step 'I fill in "deactivation-code" with "1234"'
  step 'I press "boot-bomb"'
  step 'I fill in "code" with "4321"'
  step 'I fill in "time" with "30"'
  step 'I press "activate-bomb"'
end

When(/^I enter the deactivation code$/) do
  step 'I fill in "code" with "1234"'
  step 'I press "deactivate-bomb"'
end

When(/^I submit non\-numeric activation or deactivation codes$/) do
  step 'I fill in "activation-code" with "12cd"'
  step 'I fill in "deactivation-code" with "ab34"'
  step 'I press "boot-bomb"'
end

Then(/^the bomb should not be booted$/) do
  step 'I should not see "Time:"'
  step 'I should see "Codes must be numeric"'
end

When(/^I fail to deactivate the bomb$/) do
  step 'I fill in "code" with "9999"'
  step 'I press "deactivate-bomb"'
  step 'I fill in "code" with "8888"'
  step 'I press "deactivate-bomb"'
  step 'I fill in "code" with "7777"'
  step 'I press "deactivate-bomb"'
end

Then(/^the bomb should explode$/) do
  step 'I should not see "Time:"'
end

Then /^(?:|I )should see the element id "([^\"]*)"(?: within "([^\"]*)")?$/ do |id, selector|
  with_scope(selector) do
    element = find_by_id(id)
    element.visible?
  end
end
