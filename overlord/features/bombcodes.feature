Feature: Custom codes
  When booting the bomb
  As the overlord
  I want to add activation and deactivation codes

  Scenario: Bomb can take an activation code on boot
    Given I have entered activation code ACTIVATE
    Then the activation code should be ACTIVATE

  Scenario: Bomb can take a deactivation code on boot
    Given I have entered activation code DEACTIVATE
    Then the activation code should be DEACTIVATE