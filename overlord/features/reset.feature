Feature: Reset
  As a user
  I want to be able to start from scratch, overrideing all rules
  In order to make the bomb usable more than once without clearing muy cache.

  Scenario: Reset redirection
    Given I visit the "reset" page
    Then I should be redirected to the "home" page

  Scenario: Reset kills the bomb
    Given I visit the "reset" page
    And I log in as "villain"
    Then I should see the status of the bomb is "Offline"
    