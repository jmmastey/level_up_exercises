Feature: Sign Out
  Background:
    Given there is a user
    And the user is on the home page
    And the user is logged in

  Scenario: Log Out
    When the user clicks Sign Out
    Then the user will be signed out
