Feature: Making a new bomb
  As a super villain
  In to continue my job even when existing bomb explodes
  I should be able to create a new bomb

  @javascript
  Scenario: Clicks on a Let's make a new bomb link
    Given the bomb is exploded
    When I follow "Let's make a new bomb"
    Then the bomb should be a new one