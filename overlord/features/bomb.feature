Feature: The bomb interface should include a field
  In order to destroy people
  As a bomber
  I want to acess my bomb controls

  Scenario: Create a new Bomb
    Given A new bomb is not active
    When I start the application
    Then the game should say “Super Villain's Detonation Device”
    And the game should say “Please enter your code to blow things up”
    And a form should exist with a button
