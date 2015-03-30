INCORRECT_ACTIVATION_CODE = '1235'
CORRECT_ACTIVATION_CODE = '1234'

INCORRECT_DEACTIVATION_CODE = '1255'
CORRECT_DEACTIVATION_CODE = '4321'

INCORRECT_FORMAT_CODE = '1b2fadsf'

When(/^I enter an incorrect activation code in the code field$/) do
  find('.bomb-code-input').set(INCORRECT_ACTIVATION_CODE)
end

When(/^I enter the correct activation code in the code field$/) do
  find('.bomb-code-input').set(CORRECT_ACTIVATION_CODE)
end

When(/^I enter an activation code in the activation field$/) do
  find('.bomb-activation-input').set(CORRECT_ACTIVATION_CODE)
end

When(/^I enter a deactivation code in the deactivation field$/) do
  find('.bomb-deactivation-input').set(CORRECT_DEACTIVATION_CODE)
end

When(/^I enter an incorrect deactivation code in the code field$/) do
  find('.bomb-code-input').set(INCORRECT_ACTIVATION_CODE)
end

When(/^I enter the correct deactivation code in the code field$/) do
  find('.bomb-code-input').set(CORRECT_DEACTIVATION_CODE)
end

When(/^I enter an activation code that isn't in the proper format$/) do
  find('.bomb-activation-input').set(INCORRECT_FORMAT_CODE)
end

When(/^I enter a deactivation code that isn't in the proper format$/) do
  find('.bomb-deactivation-input').set(INCORRECT_FORMAT_CODE)
end
