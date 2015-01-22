Feature: Register
  In order to get weather updates
  As a user
  I want to register

  Scenario: Register and login
    Given I register
    When I logout
    Then I login
