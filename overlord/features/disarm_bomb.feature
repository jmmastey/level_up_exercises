Feature: A Working Bomb
  As a super villain
  I want a working bomb
  So that I can cause terror

  @javascript
  Scenario: deactivate bomb
    Given I am on the homepage
    And I activate the bomb
    When I enter the deactivation code
    Then the bomb should be deactivated
