Feature: The bomb interface should include a field
  As a bomber
  I want to type in an activation / deactivation code and see the bomb state
  So that I can destroy people

  Scenario: Enter code
    Given A new bomb is not active
    When I start the application
    Then the game should say “Welcome to Blow people up”
    And the game should say “Enter code: and the current state of the bomb”
