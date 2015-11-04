Feature: Logging in
  As a shopper
  I want to log in
  In order to get food

  Scenario: Logging in to valid account
    Given I have a valid account
    And I am on the login page
    When I log in with my credentials
    Then I see that I am logged in
