#encoding: utf-8

@disarm
Feature: Disarming a bomb
  In order to disarm the bomb
  As the overlord's bomb technician
  I should have to enter the correct code

  Scenario: Disarming the bomb with a correct code
    Given I'm at the bomb page
    And I have already submitted my codes
    And the bomb is armed
    When I enter the correct disarm code
    Then the bomb should disarm
    And the timer should stop

  Scenario: Disarming the bomb with an incorrect code
    Given I'm at the bomb page
    And I have already submitted my codes
    And the bomb is armed
    When I enter the incorrect disarm code
    Then the bomb should not disarm
    And the timer should not stop