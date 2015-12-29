Feature: A Working Bomb
  As a super villain
  I want a working bomb
  So that I can cause terror

  @javascript
  Scenario: boot bomb
    Given I am on the homepage
    When I submit an activation and deactivation code
    Then the bomb should be booted
