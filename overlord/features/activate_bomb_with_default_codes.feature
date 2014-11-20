Feature: Activating the Bomb with Default Codes

  Background:
    Given the default activation and deactivation codes

  Scenario: Use default activation code
    And I enter 1234 in the enter code box
    Then the bomb should be active

  Scenario: Use default activation code and enter wrong code
    And I enter 12343 in the enter code box
    Then the bomb should be active
