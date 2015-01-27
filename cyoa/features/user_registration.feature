Feature: User Registration
  In order to view weather information
  As an unregistered user
  I want to register

  Background:
    Given I am on the registration page

  Scenario: Successful Registration
    Given I am not a registered user
    When I submit a new valid registration
    Then I am redirected to the home page
    And I receive a successful registration message

  Scenario: Blank Registration
    When I submit a blank registration
    Then I receive a registration error message

  Scenario: Invalid Registration
    When I submit an invalid registration
    Then I receive a registration error message

  Scenario: Existing User Registration Attempt
    Given some registered users
    When I submit a new registration with an existing user email
    Then I receive a user exists message