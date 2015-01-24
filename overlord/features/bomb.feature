Feature: Bomb
  In order to activate bomb
  As a super villain
  I want to enter an activation code and deactivation code

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
    Given a bomb is "inactive"
    And I am looking at the page bomb
    When I enter right "activation_code"