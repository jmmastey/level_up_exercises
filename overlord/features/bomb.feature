Feature: Bomb
  In order to activate bomb
  As a super villain
  I want to enter an activation code and deactivation code

  Scenario: Bomb is inactive
    Given a bomb is "inactive"
    And I am looking at the page bomb
    Then bomb should be "inactive"

  Scenario: Bomb is activated
    Given a bomb is "active"
    And I am looking at the page bomb
    Then bomb should be "active"

  Scenario: Bomb is exploded
    Given a bomb is "explode"
    And I am looking at the page bomb
    Then bomb should be "explode"

