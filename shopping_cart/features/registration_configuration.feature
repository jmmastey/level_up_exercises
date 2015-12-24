Feature: Registration Configuration
  In order to log-in
  As a user
  I want to register
  So that I can have a personalized user experience

  Scenario: Prevent double registraion
    Given I am on the registration page
    And I am a registered user
    When I fill out my details and submit
    Then I should be not be able to re-register
