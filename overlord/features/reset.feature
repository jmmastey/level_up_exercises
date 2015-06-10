Feature: Reset
  As a user
  I want to be able to start from scratch, overrideing all rules
  In order to make the bomb usable more than once without clearing muy cache.

  Scenario: Empty Session
    Given I visit the "reset" page
    When I am redirected to the "home" page
    Then I should have an empty session
    