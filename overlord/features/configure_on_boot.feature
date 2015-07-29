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

  Scenario Outline: The bomb only accepts 4-digit numeric activation codes
    Given I have not configured my bomb
    When I submit code "<value>"
    Then I should see "Please enter a 4-digit number"

    Examples:
      | value |
      | abcd  |
      | 12345 |
      | 123   |
  
  Scenario: I only get 2 chances to pick a good activation code
    Given I have not configured my bomb
    When I submit 2 bad activation codes
    Then I should see "Idiot!  Using default 1234."
    And I should see "Select deactivation code (default: 0000)"
    
  Scenario: Selecting an activation code should trigger the deactivation prompt
    Given I have not configured my bomb
    When I submit code "5555"
    Then I should see "Select deactivation code (default: 0000)"

  Scenario Outline: The bomb only accepts 4-digit numeric deactivation codes
    Given an activation code selection "5555"
    When I submit code "<value>"
    Then I should see "Please enter a 4-digit number"

    Examples:
      | value |
      | abcd  |
      | 12345 |
      | 123   |

  Scenario: I only get 2 chances to pick a good deactivation code
    Given an activation code selection "5555"
    When I submit 2 bad deactivation codes
    Then I should see "Idiot!  Using default 0000."
    And I should see "Control Panel"
    
  Scenario: The deactivation code must be different than the activation code
    Given an activation code selection "5555"
    When I submit code "5555"
    Then I should see "Idiot!  Using default 0000."
    And I should see "Control Panel"

  Scenario: Selecting a deactivation code should trigger the control panel
    Given an activation code selection "5555"
    When I submit code "9876"
    Then I should see "Control Panel"
