Feature: Login Menu
  Background:
    Given there is a user
    And the user is on the home page
    And the user is not logged in

  Scenario: Login Menu
    Then the menu should contain Library
    And the menu should contain Sign In
    And the menu should not contain My Books
    And the menu should not contain My Profile

  Scenario: Log In with Incorrect Password
    Given the user is logged in
    Then the menu should contain Library
    And the menu should contain Sign Out
    And the menu should contain My Books
    And the menu should contain My Profile
