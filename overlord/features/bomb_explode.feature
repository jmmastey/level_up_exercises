#encoding: utf-8
Feature: Bomb timer expires
  In order to explode
  As the bomb
  I should hit zero without being disarmed

  Scenario: The timer hits zero
    Given I'm at the bomb page
    And the bomb is armed
    When the timer hits zero
    Then the bomb should explode
    And it should no longer be disarmable
    And the timer should stop