Feature: User Login
  In order to view weather information
  As an registered user
  I want to login

  Background:
    Given I am on the login page
    And some registered users

  Scenario: Successful Login
    When I submit a valid login
    Then I am redirected to the home page
    And I receive a successful login message

  Scenario: Blank Login
    When I submit a blank login
    Then I receive a login error message

  Scenario: Invalid Login
    When I submit an invalid login
    Then I receive a login error message