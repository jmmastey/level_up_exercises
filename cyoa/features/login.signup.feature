Feature: Sign Up
  Background:
    Given the user is on the home page
    And the user is not logged in
    When the user clicks Sign In
    And the user clicks Sign up
    Then the user should be on the Sign Up page

  Scenario: Fills out Form
    When the user fills out the sign up form
    And the user presses Sign Up
    Then there will be a new user
    And the user will be signed in

  Scenario: Password Mismatch
    When the user fills out the sign up form wrong
    And the user presses Sign Up
    Then there will be a devise error: prohibited
