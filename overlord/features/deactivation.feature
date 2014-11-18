Feature: Deactivation of the bomb
  As a super villain
  In order to accomodate possible change of mind
  And to make sure the bomb is tamper proof
  I want to have complete control over the deactivation process of the bomb

  Scenario: Initial State
    Given I am yet to do anything
    When I go to the active page
    Then I should see deactivate button disabled
      And the "deactivation-code" field should contain ""
      And I should see "Bomb is Activated"

  Scenario Outline: Insert the activation code
    Given I am on the home page
    When I fill in "<code>" for "deactivation-code"
    Then I should see deactivate button <status>

    Examples:
    | code | status   |
    | 1234 | enabled  |
    | 7653 | enabled  |
    | 12b4 | disabled |
    | acvx | disabled |
    | #### | enabled  |

  Scenario Outline: Try to deactivate the bomb
    Given I have inserted "<code>" as the activation code
    When I press "deactivate"
    Then I should be on <page>

    Examples:
    | code | page            |
    | 0000 | the home page   |
    | 8988 | the active page |
    | 7653 | the active page |

  Scenario: Try to deactivate the bomb with wrong code
    Given I have tried to deactivate 1 time unsuccesfully
    Then I should see /You have (.*) tr(ies|y) remaining/
      And I should see "Bomb is activated"

  Scenario: Try to deactivate the bomb with wrong code too may times
    Given I have tried to deactivate max times unsuccesfully
    When I try to deactivate unsuccessfully again
    Then I should be on the active page
      And I should see "Bomb exploded"
      And I should see "make_new_bomb" link

    Scenario: Try to visit the active page when bomb is already deactivated
    Given the bomb is deactivated
    When I go to the active page
    Then I should see "Bomb is already deactivated"
      And I should not see "deactivation-code" field
      And I should not see "deactivate" button

  Scenario: Try to visit the active page when bomb is exploded
    Given the bomb is exploded
    When I go to the active page
    Then  I should see "Bomb expoloded"
      And I should see "make_new_bomb" link
      And I should not see "deactivation-code" field
      And I should not see "deactivate" button

