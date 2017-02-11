Feature: A Working Bomb
  As a super villain
  I want a working bomb
  So that I can cause terror

  @javascript
  Scenario: non-numeric codes
    Given I am on the homepage
    When I submit non-numeric activation or deactivation codes
    Then the bomb should not be booted

  @javascript
  Scenario: activate bomb
    Given I am on the homepage
    When I activate the bomb
    Then the bomb should be activated
