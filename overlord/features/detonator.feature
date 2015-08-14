Feature: Bomb Detonator
  Scenario: Boot State
    Given the detonator is opened
    Then the mode should be set to "disarmed"
     And the trigger button should not be active

  Scenario: Arm Bomb
    Given the mode is set to "disarmed"
    When I enter a valid code
     And I set the mode to "armed"
    Then the mode should be set to "armed"

  Scenario: Invalid Activation Code
    Given the mode is set to "disarmed"
    When I enter an invalid code
     And I set the mode to "armed"
    Then the mode should be set to "disarmed"
     And an error should be displayed

  Scenario: Activate Trigger
    Given the mode is set to "armed"
    When I enter a disarm code
    Then the trigger button should be active

  Scenario: Reset Countdown
    Given the trigger is active
      And the countdown is blank
    When I press the trigger button
    Then the countdown should be reset

  Scenario: Start Countdown
    Given the trigger is active
    When I press the trigger button
    Then the countdown should be running

  Scenario: Stop Countdown
    Given the countdown is running
    When I enter a disarm code
     And I set the mode to "disarmed"
    Then the mode should be set to "disarmed"
     And the countdown should be reset

  Scenario: Invalid Disarm Code
    Given the mode is set to "armed"
      And the countdown is running
    When I enter an invalid code
     And I set the mode to "disarmed"
    Then the mode should be set to "armed"
     And the countdown should be running
     And the countdown should be accelerated
     And an error should be displayed
