Feature: Control the bomb
  In order to make sure we can use a bomb safely
  As a super villain
  I want to activate and deactivate a bomb on command

  Background:
    Given I have booted the bomb

  Scenario: Activate the bomb
    When I enter the right activation code
    Then the bomb should activate

  Scenario: Display the activated status
    When I enter the right activation code
    Then the status indicator should show as activated

  Scenario: Display the deactivated status
    When I enter the right deactivation code
    Then the status indicator should show as deactivated

  Scenario: Deactivate the bomb
    Given I enter the right activation code
    When I enter the right deactivation code
    Then the bomb should deactivate