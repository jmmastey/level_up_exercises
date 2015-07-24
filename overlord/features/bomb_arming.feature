#encoding: utf-8

@arm
Feature: Arming the bomb
  In order to arm the bomb
  As an evil overlord
  I should have to enter the correct code

  Background:
    Given I'm at the bomb page
    And I have already submitted my codes

  @happy
  Scenario: Arming the bomb with a correct code
    When I enter the correct arm code
    Then the bomb should be armed
    And the timer should start

  @sad
  Scenario: Arming the bomb with an incorrect code
    When I enter the incorrect arm code
    Then the bomb should not be armed
    And the timer should not start