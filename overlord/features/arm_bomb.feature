Feature: Villain Arms Bomb
  In order to Arm a bomb
  As a villain
  I want to arm a bomb by entering a code

  The bomb interface should include a field to type in an activation
  and an indicator of the activation state of the bomb.

  Rules:
    - When the super villain first boots the bomb, it should not be Armed.
    - The activation code is pretty simple:
        The code should be configurable on boot. If no code is specified,
        1234 seems pretty safe. Validate that only numeric inputs are allowed.
    - When the correct activation code is entered, the bomb should Arm.
    - Putting in the same activation code again should have no effect.

  Scenario: Villain enters correct arming code
    Given I am on the "configure_bomb" page
    And the bomb is not armed
    When I enter '0000' for "arming_code"
    And  I press "Arm This Bomb!" within "configure_bomb"
    Then I should see "Bomb Status: Armed"
#
  Scenario: Villain enters incorrect arming code
    Given I am on the "configure_bomb" page
    And I have a booted bomb with default values
    And the bomb is not armed
    When I enter '2222' for "arming_code"
    And I press "Arm This Bomb!" within "configure_bomb"
    Then I should see "Bomb Status: Booted"

  Scenario: Villain enters correct arming code
    Given I am on the "configure_bomb" page
    And I have a booted bomb with default values
    When I enter '0000' for "arming_code"
    And I press "Arm This Bomb!" within "configure_bomb"
    Then I should see "Bomb Status: Armed"

  Scenario: Villain configure_bomb an arming code when bomb is armed
    Given I am on the "configure_bomb" page
    And I have an armed bomb with default values
    Then I should not see "Enter Bomb Arming Code:"
