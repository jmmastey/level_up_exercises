Feature: Logging in
  As a shopper
  I want to log in
  In order to get food

  Background:
    Given I have a valid account
    And I am on the login page

  Scenario: Logging in to valid account
    When I log in with my credentials
    Then I see that I am logged in

  Scenario: Attempting to log in with invalid email
    When I log in with the wrong email
    Then I see an invalid email/password error message

  Scenario: Attempting to log in with invalid password
    When I log in with the wrong password
    Then I see an invalid email/password error message
