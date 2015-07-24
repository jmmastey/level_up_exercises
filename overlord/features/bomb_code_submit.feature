#encoding: utf-8

@code-submit
Feature: Submitting The Arm / Disarm Codes
  In order to submit codes
  As the evil overlord
  I should enter valid arm and disarm codes
  And press submit

  Background:
    Given I'm at the bomb page

  @happy
  Scenario: I enter nothing and arm
    And I enter nothing
    When I press Submit Codes
    And I enter the correct arm code
    Then the bomb should be armed
    And I should be able to disarm the bomb

  @happy
  Scenario: I enter nothing and disarm
    And I enter nothing
    When I press Submit Codes
    And the bomb is armed
    And I enter the correct disarm code
    Then the bomb should be disarmed
    And I should be able to arm the bomb

  @happy
  Scenario: I enter only the arm code
    When I enter the arm code only
    And I press Submit Codes
    And I enter the correct arm code
    Then the bomb should be armed
    And I should be able to disarm the bomb

  @happy
  Scenario: I enter only the disarm code
    When I enter the disarm code only
    And I press Submit Codes
    And the bomb is armed
    And I enter the correct disarm code
    Then the bomb should be disarmed
    And I should be able to arm the bomb

  @happy
  Scenario: I enter both codes and arm
    When I enter both the arm and disarm code
    And I press Submit Codes
    And I enter the correct arm code
    Then the bomb should be armed
    And I should be able to disarm the bomb

  @happy
  Scenario: I enter both codes and disarm
    When I enter both the arm and disarm code
    And I press Submit Codes
    And the bomb is armed
    And I enter the correct disarm code
    Then the bomb should be disarmed
    And I should be able to arm the bomb

  @bad
  Scenario: I enter either code incorrectly
    When I enter incorrect codes
    And I press Submit Codes
    Then a flash message should appear
    And the dialog should not disappear




