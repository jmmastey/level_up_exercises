Feature: Deactivating the bomb
    
  Background: Deactivate bomb
    Given The bomb is activated

  Scenario: Attempt to deactivate less than three times with an incorrect code
    When I enter an incorrect "deactivation_code"
    Then the bomb doesn't deactivate

  Scenario: Deactivate the bomb with the correct code
    When I enter the correct deactivation code
    Then the bomb is deactivated

  Scenario: Attempt to deactivate the bomb more than three times with the incorrect code
    When I enter the incorrect deactivation code thrice
    Then the bomb should explode
