Feature: I visit the bomb page
  Background:
    Given I enter the correct codes and submit
    Given The bomb should be active

Scenario: Once bomb is armed disarm using deactivate code
    Given The bomb should be active
    When I enter the correct codes and submit
    Then The bomb should be inactive
