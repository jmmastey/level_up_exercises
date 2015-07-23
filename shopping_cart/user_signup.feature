Feature: New User
  As a new user
  I want to be able to create an account

  Background:
    Given I don't have an account
    And I securely visit the signup page

  Scenario: Create account
    And I enter in a username
    And I enter in a password
    And click create
    Then I expect to have a valid account

  Scenario: Username taken
    When I enter in a taken username
    And I enter in a password
    And click create
    Then I expect to have a username taken error

  Scenario Outline: Invalid password
    When I enter in a username
    And I enter in an invalid <password>
    And click create
    Then I expect to have an invalid password error
    