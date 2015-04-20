Feature: Deactivate Bomb
  In Order to stop explosion and save the world
  As a Super Hero
  I want to deactivate the bomb

  Background:
    Given a bomb is activated

  Scenario: deactivate the bomb with correct code
    When I enter the correct deactivation code
    Then the bomb should be deactivated

  Scenario: deactivate the bomb with correct code again
    When I enter the correct deactivation code
    Then the bomb should be deactivated

  Scenario: deactivate the bomb with wrong code
    When I enter the wrong deactivation code
    Then the bomb should not be deactivated

  Scenario: deactivate the bomb with wrong code twice
    When I enter the wrong deactivation code
    When I enter the wrong deactivation code
    Then the bomb should not be deactivated

  Scenario: deactivate the bomb with wrong code thrice
    When I enter the wrong deactivation code
    When I enter the wrong deactivation code
    When I enter the wrong deactivation code
    Then the bomb is detonated
