Feature: Bomb interface contains field to type code
  As a super villain
  I want to arm a bomb
  So that I can blow up everything

  Scenario: I boot the bomb
    Given The bomb is not booted
    When The bomb is booted
    Then I should see "bomb is not activated"

  Scenario: Activate the bomb
    Given The bomb is available
    When I fill in "code" with "1234"
    And The bomb is booted
    Then I should see "bomb is activated"

  Scenario: Activate the bomb again
    Given The bomb is available
    When I fill in "code" with "1234"
    And The bomb is booted
    Then I should see "bomb is activated"

  Scenario: Deactivate the bomb
    Given The bomb is armed
    When I fill in "code" with "0000"
    And The bomb is booted
    Then I should see "bomb is not activated"
