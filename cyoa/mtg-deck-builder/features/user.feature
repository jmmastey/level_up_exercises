Feature: Creating Users
  In order to create MTG decks
  As a MTG player
  I should be able to create user profiles

  Scenario: Create new user
    Given I visit the sign up page
    When I enter valid information
    And I sign up
    Then a new user should be saved
