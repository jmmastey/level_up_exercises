Feature: Detonator Configuration
  Scenario: Enter Config Mode
    Given the mode is set to "disarmed"
    When I enter a valid code
     And I set the mode to "configure"
    Then the mode should be set to "configure"

  Scenario: Invalid Activation Code
    Given the mode is set to "disarmed"
    When I enter an invalid code
     And I set the mode to "configure"
    Then the mode should be set to "disarmed"
     And an error should be displayed

  Scenario: Change Activation Code
    Given the mode is set to "configure"
    When I enter a new code
     And I set the mode to "disarmed"
    Then the mode should be set to "disarmed"

  Scenario: Test New Activation Code
    Given the mode is set to "configure"
    When I enter a new code
     And I set the mode to "disarmed"
     And I enter a new code
     And I set the mode to "configure"
    Then the mode should be set to "configure"

  Scenario: Test Invalidation of Old Code
    Given the mode is set to "configure"
    When I enter a new code
     And I set the mode to "disarmed"
     And I enter a valid code
     And I set the mode to "configure"
    Then the mode should be set to "disarmed"
     And an error should be displayed
