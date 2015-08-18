Feature: Bomb Detonator
  @javascript
  Scenario: Boot State
    Given the bomb is booted
    Then the bomb should be disarmed
     And the trigger button should not be active

  @javascript
  Scenario: Arm Bomb
    Given the bomb is disarmed
    When I enter a valid code
     And I arm the bomb
    Then the bomb should be armed

  @javascript
  Scenario: Invalid Activation Code
    Given the bomb is disarmed
    When I enter an invalid code
     And I arm the bomb
    Then the bomb should be disarmed
     And an error should be displayed

  @javascript
  Scenario: Activate Trigger
    Given the bomb is armed
    When I enter a disarm code
    Then the trigger button should be active

  @javascript
  Scenario: Start Countdown
    Given the trigger is active
    When I press the trigger button
    Then the countdown should be running

  @javascript
  Scenario: Stop Countdown
    Given the countdown is running
    When I enter a disarm code
     And I disarm the bomb
    Then the bomb should be disarmed
     And the countdown should not be running

  @javascript
  Scenario: Invalid Disarm Code
    Given the countdown is running
    When I enter an invalid code
     And I disarm the bomb
    Then the bomb should be armed
     And the countdown should be running
     And an error should be displayed

  @javascript
  Scenario: Too Many Invalid Disarm Attempts
    Given the bomb is armed
      And the countdown is running
    When I enter an invalid code
     And I enter an invalid code
     And I enter an invalid code
    Then the bomb should have exploded

  @javascript
  Scenario: Expose the Wires
    Given the bomb is booted
    When I open the wire panel
    Then the wires should be exposed

  @javascript
  Scenario: Cut a Detonating Wire on an Armed Bomb
    Given the bomb is armed
      And the wires are exposed
    When I cut a detonating wire
    Then the bomb should have exploded

  @javascript
  Scenario: Cut a Detonating Wire on a Disarmed Bomb
    Given the bomb is disarmed
      And the wires are exposed
    When I cut a detonating wire
    Then the bomb should not have exploded

  @javascript
  Scenario: Cut a Detonating Wire on a Disarmed Bomb and then Arm the Bomb
    Given the bomb is disarmed
      And the wires are exposed
    When I cut a detonating wire
     And I arm the bomb
    Then the bomb should have exploded

  @javascript
  Scenario: Cut a Disarming Wire
    Given the bomb is booted
      And the wires are exposed
    When I cut a disarming wire
    Then the interface should not be disabled
     And the bomb should not have exploded

  @javascript
  Scenario: Cut all Disarming Wires
    Given the bomb is booted
      And the wires are exposed
    When I cut all the disarming wires
    Then the interface should be disabled
     And the countdown should not be running
     And the bomb should not have exploded

  @javascript
  Scenario: Countdown Complete
    Given the countdown is running
    When the countdown ends
    Then the bomb should have exploded

  @javascript
  Scenario: Bomb Exploded
    Given the bomb exploded
    Then the interface should be disabled
