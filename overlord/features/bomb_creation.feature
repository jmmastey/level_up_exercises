Feature: Bomb Creation
  As a villian
  I want to be able to create a new bomb

  Scenario: Create a bomb
    Given there are no bombs
    When I create a bomb
    And enter an activation code
    And enter a deactivation code
    And press the create button
    Then there should be a bomb
    And the status should be inactive