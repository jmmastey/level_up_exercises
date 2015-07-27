Feature: Configure activation and deactivation codes on boot
  In order to ensure I'm the only one who can manipulate my bomb
  As a super villian
  I want to choose my own activation and deactivation codes for a new bomb

  Scenario: On boot I am prompted for an activation code
    Given a newly booted bomb
    Then I should see "Select activation code (default: 1234)"

  Scenario: The bomb accepts the activation code I enter at the prompt
    Given a newly booted bomb
    When I fill in "code" with "5555"
    Then the activation code is "5555"

  Scenario: The activation code defaults to 1234
    Given a newly booted bomb
    When I fill in "code" with ""
    Then the activation code is "1234"

  Scenario Outline: The bomb only accepts 4-digit numeric activation codes
    Given a newly booted bomb
    When I fill in "code" with "<value>"
    Then I should see "Please enter a 4-digit number"

    Examples:
      | value |
      | abcd  |
      | 12345 |
      | 123   |
  
  Scenario: The bomb uses the default activation code if I fail twice
    Given a newly booted bomb
    When I fill in "code" with 2 bad codes
    Then I should see "Idiot!  Using default 1234."
    And the activation code is "1234"

  Scenario: After setting activation code I am prompted for a deactivation code
    Given a newly booted bomb
    When I fill in "code" with "1234"
    Then I should see "Select deactivation code (default: 0000)"

  Scenario: The bomb accepts the deactivation code enter at the prompt
    Given a newly booted bomb with activation code "5555"
    When I fill in "code" with "1111"
    Then the activation code is "5555"
    And the deactivation code is "1111"

  Scenario Outline: The bomb only accepts 4-digit numeric deactivation codes
    Given a newly booted bomb with activation code "5555"
    When I fill in "code" with "<value>"
    Then I should see "Please enter a 4-digit number"

    Examples:
      | value |
      | abcd  |
      | 12345 |
      | 123   |

  Scenario: The bomb uses the default deactivation code if I fail twice
    Given a newly booted bomb with activation code "5555"
    When I fill in "code" with 2 bad codes
    Then I should see "Idiot!  Using default 0000."
    And the activation code is "5555"
    And the deactivation code is "0000"

  Scenario: The deactivation code must be different than the activation code
    Given a newly booted bomb with activation code "5555"
    And I fill in "code" with "5555"
    Then I should see "Idiot!  Using default 0000."
    And the activation code is "5555"
    And the deactivation code is "0000"
