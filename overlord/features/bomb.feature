Feature: I visit the bomb page
  Background:
    Given I go to the home page
    And I enter the correct codes and submit
    And the bomb should be active

Scenario: Once bomb is armed disarm using deactivate code
    Given the bomb should be active
    When I enter the correct codes and submit
    Then the bomb should be inactive
