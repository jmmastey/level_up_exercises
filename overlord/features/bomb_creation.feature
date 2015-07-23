Feature: Bomb Creation
  In order to explode a bomb
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

  Scenario: View an existing bomb
    Given there is a bomb
    When I view my bomb
    Then there should be a bomb with a panel

  Scenario: Missing activation code
    Given there are no bombs
    When I create a bomb
    And enter an activation code
    And press the create button
    Then there should be an error dialogue

  Scenario: Missing deactivation code
    Given there are no bombs
    When I create a bomb
    And enter a deactivation code
    And press the create button
    Then there should be an error dialogue

  Scenario: Missing activation and deactivation code
    Given there are no bombs
    When I create a bomb
    And press the create button
    Then there should be an error dialogue