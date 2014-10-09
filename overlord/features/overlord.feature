Feature: Bomb interface contains field to type code
  As a super villain
  I want to arm a bomb
  So that I can blow up everything

  Scenario: I boot the bomb
    Given The bomb is available
    When The bomb is booted
    Then I should see "bomb is not activated"

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
