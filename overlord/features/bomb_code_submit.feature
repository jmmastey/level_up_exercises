#encoding: utf-8

@code-submit
Feature: Submitting The Arm / Disarm Codes
  In order to submit codes
  As the evil overlord
  I should enter two valid 4-digit numbers
  And press submit

  @happy
  Scenario: I enter nothing and arm
    Given I'm at the bomb page
    And I enter nothing
    When I press Submit Codes
    And the bomb is disarmed
    And I enter the correct arm code
    Then the bomb should arm
    And I should be able to disarm the bomb

  @happy
  Scenario: I enter nothing and disarm
    Given I'm at the bomb page
    And I enter nothing
    When I press Submit Codes
    And the bomb is armed
    And I enter the correct disarm code
    Then the bomb should disarm
    And I should be able to arm the bomb

  @happy
  Scenario: I enter only the arm code
    Given I'm at the bomb page
    When I enter the arm code only
    And I press Submit Codes
    And the bomb is disarmed
    And I enter the correct arm code
    Then the bomb should arm
    And I should be able to disarm the bomb

  @happy
  Scenario: I enter only the disarm code
    Given I'm at the bomb page
    When I enter the disarm code only
    And I press Submit Codes
    And the bomb is armed
    And I enter the correct disarm code
    Then the bomb should disarm
    And I should be able to arm the bomb

  @happy
  Scenario: I enter both codes and arm
    Given I'm at the bomb page
    When I enter both the arm and disarm code
    And I press Submit Codes
    And the bomb is disarmed
    And I enter the correct arm code
    Then the bomb should arm
    And I should be able to disarm the bomb

  @happy
  Scenario: I enter both codes and disarm
    Given I'm at the bomb page
    When I enter both the arm and disarm code
    And I press Submit Codes
    And the bomb is armed
    And I enter the correct disarm code
    Then the bomb should disarm
    And I should be able to arm the bomb

  @bad
  Scenario: I enter either code incorrectly
    Given I'm at the bomb page
    When I enter incorrect codes
    And I press Submit Codes
    Then a flash message should appear
    And the dialog should not disappear




