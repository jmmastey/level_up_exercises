#encoding: utf-8

@bad-codes
Feature: Entering incorrect bomb codes
  In order to detonate the bomb
  As an unfortunate soul
  I should enter an incorrect code 3 times

  @happy
  Scenario: Entering the incorrect code 3 times
    Given I'm at the bomb page
    And I have already submitted my codes
    And the bomb is disarmed
    When I enter the incorrect disarm code
    And I enter the incorrect disarm code again
    And I enter the incorrect disarm code again
    Then the bomb should explode
    And I should be unable to arm the bomb
    And I should be unable to disarm the bomb