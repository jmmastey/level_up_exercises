Feature: The bomb be able to be activated and deactivated
  In order to use the bomb
  As a bomber
  I want to activate and deactivate the bomb

  Scenario: Activate a Bomb
    Given I visit the root page
    When I submit the activation code
    Then the bomb will be active

  Scenario: De-activate a Bomb
    Given I visit the root page again
    When I submit the deactivation code
    Then the bomb will be Inactive
