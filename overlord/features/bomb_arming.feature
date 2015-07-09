#encoding: utf-8

@arm
Feature: Arming the bomb
  In order to arm the bomb
  As an evil overlord
  I should have to enter the correct code

  Scenario: Arming the bomb with a correct code
    Given I'm at the bomb page
    And I have already submitted my codes
    And the bomb is disarmed
    When I enter the correct arm code
    Then the bomb should arm
    And the timer should start

  Scenario: Arming the bomb with an incorrect code
    Given I'm at the bomb page
    And I have already submitted my codes
    And the bomb is disarmed
    When I enter the incorrect arm code
    Then the bomb should not arm
    And the timer should not start