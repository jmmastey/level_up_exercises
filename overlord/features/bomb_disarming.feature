#encoding: utf-8
Feature: Disarming a bomb
  In order to disarm the bomb
  As the overlord's bomb technician
  I should have to enter the correct code

  Scenario: Disarming the bomb with a correct code
    Given I'm at the bomb page
    And the bomb is armed
    And I know the correct bomb code
    When I enter the code and submit
    Then the bomb should disarm
    And the timer should stop

  Scenario: Disarming the bomb with an incorrect code
    Given I'm at the bomb page
    And the bomb is armed
    And I don't know the correct bomb code
    When I enter the code and submit
    Then the bomb should not disarm
    And the timer should not stop