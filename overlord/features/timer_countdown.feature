Feature: Timer Countdown
  In order to know when the bomb will detonate
  As someone close to the bomb proximity
  I want a coutdown timer of how much time is left

  Scenario: the timer should decrement every second
    Given I am on the bomb page
    And the bomb is armed
    Then the timer should start counting down

  Scenario: the timer should decrement every second
    Given I am on the bomb page
    And the bomb is armed
    And the timer has less than ten seconds left
    Then the timer should be in danger mode

  Scenario: the bomb explodes when the timer hits zero
    Given I am on the bomb page
    And the bomb is armed
    And the timer runs out
    Then the bomb state should be exploded