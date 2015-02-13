Feature: Bomb will boot with either specified or default activation and deactivation codes set
  As an evil mastermind
  I want to boot the bomb
  In order to activate it

  Background:
    Given I can see the unbooted bomb

  Scenario: Visit home page
    Then I see fields to enter activation/deactivation codes
    And I see a switch to boot the bomb

  Scenario: Enter default activation/deactivation codes
    When I boot the bomb
    Then the bomb is booted, but deactivated

  Scenario: Enter custom activation/deactivation codes
    When I enter "1234" for the activation code
    And I enter "9876" for the deactivation code
    And I boot the bomb
    Then the bomb is booted, but deactivated

  Scenario Outline: Invalid activation code
    When I enter <activation> for the activation code
    And I enter <deactivation> for the deactivation code
    And I boot the bomb
    Then the bomb is not booted

    Examples:
      |  activation  |  deactivation  |
      |  "9999"      |  "9876"        |
      |  "9999"      |  "9876"        |

  Scenario Outline: Invalid deactivation code
    When I enter <activation> for the activation code
    And I enter <deactivation> for the deactivation code
    And I boot the bomb
    Then the bomb is not booted

    Examples:
      |  activation  |  deactivation  |
      |  "2222"      |  "9999"         |
      |  "2222"      |  "9999"        |