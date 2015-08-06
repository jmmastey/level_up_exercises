Feature: Logging in and logging out
  In order to save MTG decks
  As a MTG player
  I should be able to log in and log out

  Scenario: Log in
    Given I created a user
    When I log in
    Then I should be logged in

  Scenario: Log Out
    Given I created a user
    And I log in
    When I log out
    Then I should be logged out
