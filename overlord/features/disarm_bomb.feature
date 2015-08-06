Feature: Disarm Bomb

The disarming code.
  - This code should be configurable as well. A good default code would
  be 0000.
  - Once the bomb is active, putting in the correct disarming code should
  cause the bomb to revert to inactivity, and indicate as such.
  - If a user puts in the wrong disarming code three times, the bomb
  should explode. I'm not really sure what the interface would look like
  for this, since the bomb is exploded and all, but let's just indicate
  it somehow to be sure.
  - Once a bomb has exploded, none of the buttons work anymore. Obv.
  - From the time the bomb is activated, the status indicator should let the
  user know that the bomb is active.

#  Background:
#    Given I am on the disarm bomb page

  Scenario: I go to the disarm bomb page and the bomb is not armed
    Given I am on the "disarm_bomb" page
    And I have a booted bomb with default values
    Then I should see "Bomb Status: Booted"
    And I should not see "Disarm bomb"

  Scenario: The bomb is armed and I enter the correct disarming code
    Given I have an armed bomb ready to disarm
    And I am on the "disarm_bomb" page
    When I enter '1234' for "disarming_code"
    And I press "Disarm This Bomb!" within "disarm_bomb"
    Then I should see "You have disarmed the bomb"

#  Scenario: The bomb is armed and I enter the incorrect disarming code
#    Given I have an armed bomb ready to disarm
#    And I am on the "disarm_bomb" page
#    When I enter '4444' for "disarming_code"
#    And I press "Disarm This Bomb!" within "outcome"
#    Then I should see "You have 2 tries left." within "outcome"

#  Scenario Outline: Three failed disarming attempts
#    And The bomb is armed
#    When I enter <code> for 'disarming_code'
#    Then I should see <bomb_status>
#    And I should see <attempt_status> for attempt_status
#
#    Examples:
#      | code    | bomb_status      | attempt_status |
#      |  1235   | "Bomb is Armed"  | "1st Attempt"  |
#      |  7777   | "Bomb is Armed"  | "2nd Attempt"  |
#      |  5325   | "Bomb is Armed"  | "3rd Attempt"  |
