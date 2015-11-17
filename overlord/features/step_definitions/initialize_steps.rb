CODE_WITH_INVALID_FORMAT = 'ABCD'

DEFAULT_ACTIVATION_CODE = '1234'
DEFAULT_DEACTIVATION_CODE = '0000'

INVALID_CODE = 'ABCD'
CUSTOM_CODE = '9999'

def boot_the_bomb
  steps <<-eos
    Given I am on the initialize page
    When I press "Boot"
  eos
end

Given /^that the bomb is booted$/ do
  boot_the_bomb
end

Given /^that the bomb is booted with a custom (.*) key$/ do |code_type|
  steps <<-eos
    Given I am on the initialize page
    When I fill in "#{code_type}_code" with "#{CUSTOM_CODE}"
    And I press "Boot"
  eos
end

When /^the bomb is first booted$/ do
  boot_the_bomb
end
