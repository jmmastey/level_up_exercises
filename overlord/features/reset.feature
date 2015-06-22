Feature: Reset
  As a user
  I want to be able to start from scratch, overrideing all rules
  In order to make the bomb usable more than once without clearing muy cache.

  Scenario: Reset redirection
    When I visit the reset page
    Then I should be redirected to the login page

  Scenario: Reset logs user out
    When I visit the reset page
    Then I should not be logged in

  Scenario: Reset allows use of the site
    Given the bomb has exploded
    When I visit the reset page
    Then I should be able to login

  Scenario: Reset allows use of the site
    Given the bomb has exploded
    When I visit the reset page
    And I login as a villain
    Then I should see the bomb is offline
    