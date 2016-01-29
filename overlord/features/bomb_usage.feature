Feature: The bomb be able to be activated and deactivated
  In order to use the bomb
  As a bomber
  I want to activate and deactivate the bomb

  Scenario: Activate a Bomb
    Given I have entered the correct activation code
    When I submit the code
    Then the bomb will be active

  Scenario: De-activate a Bomb
    Given I have entered the correct de-activation code
    When I submit the code
    Then the bomb will be Inactive
