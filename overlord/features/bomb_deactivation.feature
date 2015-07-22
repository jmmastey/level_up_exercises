Feature: Deactivate bomb
  In order to stop a bomb from exploding
  As a villian
  I want to be able to enter in a deactivation code
    and stop the bomb from exploding

  Background:
    Given there is a bomb
    And I click the activation button
    And I enter in the correct activation code
    And the status to equal ARMED
    And I click the deactivation button

  Scenario: Deactivate a bomb
    Given I enter in the correct deactivation code
    When I click the confirm button
    Then I should see the timer stop
    And the status should be DEACTIVATED
    And the activation button should not work
    And the deactivation button should not work

  Scenario Outline: Explode bomb by entering incorrect deactivation code 3 times
    Given I see the keypad
    When I enter in the incorrect deactivation code <first>
    And I click the deactivation button
    And I enter in the incorrect deactivation code <second>
    And I click the deactivation button
    And I enter in the incorrect deactivation code <third>
    Then I should see the bomb explode

    Examples:
      | first | second | third |
      | 1111  | 2222   | 3333  |
      | 1231  | 1231   | 1231  |
      | 0000  | 0000   | 0000  |