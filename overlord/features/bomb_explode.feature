#encoding: utf-8

@explode
Feature: Bomb timer expires
  In order to explode
  As the bomb
  I should hit zero without being disarmed

  Scenario: The timer hits zero
    Given I'm at the bomb page
    And the bomb is armed
    When the timer hits zero
    Then the bomb should explode
    And I should be unable to arm the bomb
    And I should be unable to disarm the bomb
    And the timer should stop