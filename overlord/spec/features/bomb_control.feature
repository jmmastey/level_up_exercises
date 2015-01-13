Feature: Control the bomb
  In order to make sure we can use a bomb safely
  As a super villain
  I want to activate and deactivate a bomb on command

  Background:
    Given I have booted the bomb

  Scenario: Activate the bomb
    When I enter the right activation code
    Then the status indicator shows as activated

  Scenario: Deactivate the bomb
    Given I enter the right activation code
    And the status indicator shows as activated
    When I enter the right deactivation code
    Then the status indicator shows as deactivated