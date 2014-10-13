Feature: Boot the bomb
  As a super villain
  I want to boot a bomb
  So that I can blow up everything

  Scenario: I visit the bomb booting page
    Given The bomb is not booted
    When I visit the bomb booting page
    Then I should see "The bomb"
    And the "activation_code" field should contain "1234"
    And the "deactivation_code" field should contain "0000"

  Scenario: I boot the bomb with default codes
    Given The bomb is not booted
    When I visit the bomb booting page
    And I press "arm-button"
    Then I should see "bomb is not activated"

  Scenario Outline: I boot the bomb with custom codes
    Given The bomb is not booted
    When I visit the bomb booting page
    And I fill in "activation_code" with "<activation_code>"
    And I fill in "deactivation_code" with "<deactivation_code>"
    And I press "arm-button"
    Then I should see "<message>"

  Examples:
    | activation_code | deactivation_code | message               |
    | 1234            | 0000              | bomb is not activated |
    | 9876            | 9999              | bomb is not activated |
    | 5               | 5                 | bomb is not activated |
    | 132456789       | 987654321         | bomb is not activated |
    | qwerty          | asdfg             | not booted            |
    | 123q            | 000a              | not booted            |