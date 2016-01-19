Feature: Default bomb initialization
  When booting the bomb
  As the overlord
  I want some things to auto initialize without extra input

  Scenario: Bomb is inactive by default
    Given I have just booted the bomb
    Then the bomb active state should be false

  Scenario: Bomb has a default activation code
    Given I have not entered an activation code
    Then the activation code should default to 1234

  Scenario: Bomb has a default deactivation code
    Given I have not entered an deactivation code
    Then the deactivation code should default to 0000
