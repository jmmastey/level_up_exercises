Feature: A Working Bomb
  As a super villain
  I want a working bomb
  So that I can cause terror

  @javascript
  Scenario: Failure to deactivate then the bomb should explode
    Given I am on the homepage
    And I activate the bomb
    When I fail to deactivate the bomb
    Then the bomb should explode
