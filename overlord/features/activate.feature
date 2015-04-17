Feature: Activate Bomb
  In Order to destroy the world
  As a Super Villian
  I want to activate the bomb

  Background:
    Given a bomb is installed

  Scenario: activate the bomb with correct code
    When I enter the correct activation code
    Then the bomb should be activated

  Scenario: activate the bomb with correct code twice
    When I enter the correct activation code
    When I enter the correct activation code
    Then the bomb should be activated

  Scenario: activate the bomb with wrong code
    When I enter the wrong activation code
    Then the bomb should not be activated
