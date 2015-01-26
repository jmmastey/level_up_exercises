Feature: Users Register
  In order to view weather information
  As an unregistered user
  I want to register

  Scenario: New User Registration
    Given I am not a registered user
    And I am on the registration page
    When I fill in a valid registration email and password
    Then I am redirected to the home page
    And I receive a successful registration message