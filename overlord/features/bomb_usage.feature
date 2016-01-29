Feature: The bomb be able to be activated and deactivated
  In order to use the bomb
  As a bomber
  I want to activate and deactivate the bomb

  Scenario: Activate a Bomb
    Given The correct code
    When I start the application
    Then the game should say “Super Villain's Detonation Device”
