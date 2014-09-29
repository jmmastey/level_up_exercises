Feature: Bomb Responses
  In order to test the Bomb class
  As a developer who wrote Bomb
  I want to ensure the bomb responds correctly to actions

  Background:
    Given I create a bomb with default codes

  Scenario: Activate bomb
    When I activate the bomb
    Then it should respond with "Bomb activated - Look Out!"

  Scenario: Activate bomb twice
    When I activate the bomb
    When I activate the bomb
    Then it should respond with "Bomb is already active"

  Scenario: Deactivate bomb
    When I activate the bomb
    And  I deactivate the bomb
    Then it should respond with "Bomb deactivated"

  Scenario: Deactivate bomb twice
    When I activate the bomb
    And  I deactivate the bomb
    And  I deactivate the bomb
    Then it should respond with "Bomb is already inactive"

  Scenario: Detonate bomb
    When I detonate it
    Then it should respond with "Bomb has been detonated!"

  Scenario: Snip wires
    When I snip the wires
    Then it should respond with "Bomb wires snipped and is now defunct"

  Scenario: Unsuccessful deactivation attempt
    When I activate the bomb
    And I unsuccessfully deactivate it 1 time
    Then it should respond with "Wrong code"

  Scenario: Too many unsuccessful deactivation attempts
    When I activate the bomb
    And I unsuccessfully deactivate it 3 times
    Then it should respond with "Bomb exploded - too many attempts!"

  Scenario: Try to snip the wires after it has already exploded
    When I detonate it
    And I snip the wires
    Then it should respond with "Sorry, bomb has already exploded"

  Scenario: Try to activate a bomb after the wires have been snipped
    When I snip the wires
    And I activate the bomb
    Then it should respond with "Sorry, bomb wires have been snipped"

  Scenario: Try to enter a non-integer code
    When I activate it with code ABCD
    Then it should respond with "Code must be an integer"
