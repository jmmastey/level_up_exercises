Feature: Login User
  Background:
    Given there is a user
    And the user is on the home page
    And the user is not logged in

  Scenario: Log in
    When the user clicks Sign In
    And the user fills in the login form with test_user@gmail.com and 12345678
    And the user presses Log In
    Then the user will be logged in

  Scenario: Log In with Incorrect Password
    When the user clicks Sign In
    And the user fills in the login form with test_user@gmail.com and 87654321
    And the user presses Log In
    Then there will be a devise error: Invalid email or password
