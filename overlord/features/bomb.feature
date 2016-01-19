Feature: Interface
  When booting the bomb
  As the overlord
  I want some things to auto initialize without extra input

  Scenario: Bomb is inactive by default
    Given I have just booted the bomb
    As the overlord
    Then the bomb active state should be false

  Scenario: Bomb has a default activation code
    Given I have not entered an activation code
    As the overlord
    Then the activation code should default to 1234

  Scenario: Bomb can take an activation code on boot
    Given I have entered activation code ACTIVATE
    As the overlord
    Then the activation code should be ACTIVATE

  Scenario: Bomb has a default deactivation code
    Given I have not entered an deactivation code
    As the overlord
    Then the activation code should default to 0000

  Scenario: Bomb can take a deactivation code on boot
    Given I have entered activation code DEACTIVATE
    As the overlord
    Then the activation code should be DEACTIVATE
