Feature: Deactive bomb
  As a User
  I want to deactivate the bomb
  In order to prevent it from exploding

  Background:
    Given I have entered the activation and deactivation codes

  Scenario: The bomb deactivates if the correct deactivation code is entered
    Given the bomb is active
    When I enter my correct deactivation code
    Then the bomb should be deactivated
