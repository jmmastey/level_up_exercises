#encoding: utf-8
Feature: Arming the bomb
  In order to arm the bomb
  As an evil overlord
  I should have to enter the correct code

  Scenario: Arming the bomb with a correct code
    Given I'm at the bomb page
    And the bomb is disarmed
    And I know the correct bomb code
    When I enter the code and submit
    Then the bomb should arm
    And the timer should start

  Scenario: Arming the bomb with an incorrect code
    Given I'm at the bomb page
    And the bomb is disarmed
    And I don't know the correct bomb code
    When I enter the code and submit
    Then the bomb should not arm
    And the timer should not start