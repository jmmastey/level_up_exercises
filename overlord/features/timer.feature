Feature: Timer
  In order to have the bomb explode 2 hours after activation
  As a supervillain
  I want the bomb to be triggered by a timer

  Scenario: The timer initializes at 2 hours
    Given an inactive bomb
    When I activate the bomb
    Then the "countdown" field should contain "02:00:00"

  Scenario: The bomb does not explode early
    Given an active bomb with timer at "00:00:01"
    Then the bomb is active

  Scenario: The bomb explodes when the timer reaches "00:00:00"
    Given an active bomb with timer at "00:00:01"
    Then 2 seconds later the bomb is exploded

  Scenario: The timer stops counting down when the bomb is deactivated
    Given an active bomb with deactivation code "0000" with timer at "00:54:32"
    When I fill in "code" with "0000"
    Then the "countdown" field stops at "00:54:32"

  Scenario: The timer resumes counting down when the bomb is reactivated
    Given an inactive bomb with timer at "00:54:32"
    When I activate the bomb
    Then 2 seconds later the "countdown" field should contain "00:54:30"