Feature: Authentication
  As a user
  I want to be directed to the login page
  In order to log in to my account

  Scenario: Visiting homepage without access
    When I visit the home page
    Then I am redirected to the login page
    And I see I must log in before continuing
