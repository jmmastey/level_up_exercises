Feature: Boot the bomb
  As a super villain
  I want to boot a bomb
  So that I can blow up everything

  Background:
    Given The bomb is not booted
    When I go to 'the home page'

  @happy
  Scenario: I visit the bomb booting page
    Then I should see "bomb status not booted"
    And the "activation_code" field should contain "1234"
    And the "deactivation_code" field should contain "0000"

  @happy
  Scenario: I boot the bomb with default codes
    And I press "boot-button"
    Then I should see "bomb status not activated"

  Scenario Outline: I boot the bomb with custom codes
    And I fill in "activation_code" with "<activation_code>"
    And I fill in "deactivation_code" with "<deactivation_code>"
    And I press "boot-button"
    Then I should see "<message>"

  @happy
  Examples:
    | activation_code | deactivation_code | message                   |
    | 1234            | 0000              | bomb status not activated |

  @sad
  Examples:
    | activation_code | deactivation_code | message                   |
    | 9876            | 9999              | bomb status not activated |
    | 5               | 5                 | bomb status not activated |
    | 132456789       | 987654321         | bomb status not activated |

  @bad
  Examples:
    | activation_code | deactivation_code | message                   |
    | 1324567890      | 0987654321        | bomb status not booted    |
    | qwerty          | asdfg             | bomb status not booted    |
    | 123q            | 000a              | bomb status not booted    |
    |                 |                   | bomb status not booted    |
