Feature: Log-in
  In order to log-in
  As a user
  I want to log-in
  So that I can prevent unauthorized access

  Scenario: Registration
    Given I am not registered as a user
    When I am on the home page
    And I click on the registration link
    Then I should be directed to the registraion page

  Scenario: Register as a user
    Given I am on the registration page
    And I am not a registered user
    When I fill out my details and submit
    Then I should be registered

  Scenario: Prevent double registraion
    Given I am on the registration page
    And I am a registered user
    When I fill out my details and submit
    Then I should be not be able to re-register

  Scenario: Log-in as a user
    Given I am on the home page
    And I am a registered user
    When I fill in the username and password and click submit
    Then I should be logged in

  Scenario: Prevent logging in if not registered
    Given I am on the home page
    And I am not a registered user
    When I fill in the username and password and click submit
    Then I should not be logged in
    And the page should show the error message
