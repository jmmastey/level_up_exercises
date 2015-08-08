Feature: Configure activation and deactivation codes
  In order to ensure I'm the only one who can manipulate my bomb
  As a super villian
  I want to choose my own activation and deactivation codes for a new bomb

  Scenario: A new bomb requires configuration before it can be used
    Given I go to my bomb
    Then I should see "Configuration Panel"
    And I should not see "Control Panel"

  Scenario: The configuration panel prompts me for an activation code
    Given I have not configured my bomb
    Then I should see "Select activation code (default: 1234)"
    
  Scenario: Selecting an activation code should trigger the deactivation prompt
    Given I have not configured my bomb
    When I submit code "5555"
    Then I should see "Select deactivation code (default: 0000)"

  Scenario: Activation code "" triggers the deactivation prompt
    Given I have not configured my bomb
    When I submit code ""
    Then I should see "Select deactivation code (default: 0000)"

  Scenario: Entering activation code "" sets activation code to "1234"
    Given an inactive bomb with activation code ""
    When I activate the bomb with "1234"
    Then the bomb is active

  Scenario: Selecting a deactivation code should trigger the control panel
    Given an activation code selection "5555"
    When I submit code "9876"
    Then I should see "Control Panel"

  Scenario: Dectivation code "" triggers the control panel
    Given an activation code selection "5555"
    When I submit code ""
    Then I should see "Control Panel"

  Scenario: Entering deactivation code "" sets deactivation code to "0000"
    Given an active bomb with deactivation code "0000"
    When I submit code "0000"
    Then the bomb is inactive

  Scenario Outline: The bomb only accepts 4-digit numeric activation codes
    Given I have not configured my bomb
    When I submit code "<value>"
    Then I should see "Please enter a 4-digit number"

    Examples:
      | value |
      | abcd  |
      | 12345 |
      | 123   |
    
  Scenario Outline: The bomb only accepts 4-digit numeric deactivation codes
    Given an activation code selection "5555"
    When I submit code "<value>"
    Then I should see "Please enter a 4-digit number"

    Examples:
      | value |
      | abcd  |
      | 12345 |
      | 123   |

  Scenario: The deactivation code must be different than the activation code
    Given an activation code selection "5555"
    When I submit code "5555"
    Then I should see "Idiot!  Using default 0000."
    And I should see "Control Panel"
