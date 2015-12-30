Feature: Registration Configuration
  In order to log-in
  As a user
  I want to register
  So that I can have a personalized user experience

  Scenario: Prevent double registration
    Given I am on the registration page
    And I am a registered user
    When I fill out and submit my username and password
    Then I should be not be able to re-register
