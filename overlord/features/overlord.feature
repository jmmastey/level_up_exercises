Feature: Bomb interface contains field to type code
  As a super villain
  I want to arm a bomb
  So that I can blow up everything

  Scenario: Deactivate the bomb
    Given The bomb is armed
    When I fill in "code" with "0000"
    And The bomb is booted
    Then I should see "bomb is not activated"
