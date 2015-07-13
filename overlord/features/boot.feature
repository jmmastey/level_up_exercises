Feature: Bomb
  Background:
    Given I have a new bomb

  Scenario: New Bomb
    Then I should see an unbooted bomb

  Scenario: Boot Bomb
    When I boot the bomb
    Then The bomb is inactive

