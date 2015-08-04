Feature: Creating Users
  In order to save MTG decks
  As a MTG player
  I should be able to create user profiles

  Scenario: Create new user
    Given I visit the sign up page
    When I enter valid information
    And I sign up
    Then a new user should be saved

  Scenario: Log in
    Given I created a user
    When I log in
    Then I should be taken to the user profile page