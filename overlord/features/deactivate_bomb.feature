Feature: Deactivating the bomb
    
  Background: Deactivate bomb
    Given The bomb is activated

  Scenario: Attempt to deactivate less than three times with an incorrect code
    When I enter an incorrect "deactivation_code"
    Then the bomb doesn't deactivate

  Scenario
