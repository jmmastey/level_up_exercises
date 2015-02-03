Feature: Making a branch new bomb
  As the supreme overlord
  After exploding a bomb
  I should be able to create another brand new bomb

  @javascript
  Scenario: Start up a brand new bomb
    Given the bomb is exploded
    When I follow "Start up a new bomb"
    Then the bomb should be a new one