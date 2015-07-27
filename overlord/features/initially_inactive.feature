Feature: Bomb is initially inactive
  In order to safely move my bomb to the place it will do the most damage
  As a super villian
  I want to have the bomb start out inactive

  Scenario: A new bomb is inactive
    Given a newly constructed bomb
    Then the bomb is inactive

  Scenario: Configuring a bomb does not activate it
    Given a newly constructed bomb
    When I configure the codes
    Then the bomb is inactive