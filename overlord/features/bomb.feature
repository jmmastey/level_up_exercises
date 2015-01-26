Feature: Bomb status

  Scenario: Bomb is inactive
    Given a bomb is "inactive"
    And I am looking at the page bomb
    Then the bomb status is "Inactive"

  Scenario: Bomb is activated
    Given a bomb is "active"
    And I am looking at the page bomb
    Then the bomb status is "Active"

  Scenario: Bomb is exploded
    Given a bomb is "explode"
    And I am looking at the page bomb
    Then the bomb status is "Explode"

  Scenario: Activate a bomb
    Given a bomb is "active"
    And I am looking at the page bomb
    When I enter "0000" for "deactivation_code"
    Then I press "Deactivate" within "bomb_control"
    Then the bomb should not be active

