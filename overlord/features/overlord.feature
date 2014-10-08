Feature: Bomb interface contains field to type code

  Scenario: Super villain boots the bomb
    Given The bomb is available
    When The bomb is booted
    Then The bomb should not be activated

  Scenario: Activate the bomb
    Given The bomb is available
    When The activation code is used
    Then The bomb should be activated

  Scenario: Activate the bomb again
    Given The bomb is activated
    When The activation code is used
    Then The bomb should be activated

  Scenario: Deactivate the bomb
    Given The bomb is activated
    When The deactivation code is used
    Then The bomb should be deactivated

  