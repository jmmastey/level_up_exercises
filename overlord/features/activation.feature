Feature: Activation of the bomb
  As a super villain
  In order to blast everything imaginable
  I want to have complete control over the activation process of the bomb

  Scenario: Initial State
    Given I am yet to do anything
    When I go to the home page
    Then I should see activate button disabled
      And the "activation-code" field should contain ""
      And I should see "Bomb is deactivated"

  Scenario Outline: Insert the activation code
    Given I am on the home page
    When I fill in "<code>" for "activation-code"
    Then I should see activate button <status>

    Examples:
    | code | status   |
    | 1234 | enabled  |
    | 7653 | enabled  |
    | 12b4 | disabled |
    | acvx | disabled |
    | #### | enabled  |

  Scenario Outline: Try to activate the bomb
    Given I have inserted "<code>" as the activation code
    When I press "activate"
    Then I should be on <page>

    Examples:
    | code | page            |
    | 1234 | the active page |
    | 8988 | the home page   |
    | 7653 | the home page   |

  Scenario: Try to visit the home page when bomb is already activated
    Given the bomb is activated
    When I go to the home page
    Then I should see "Bomb is already activated"
      And I should not see "activation-code" field
      And I should not see "activate" button

  Scenario: Try to visit the home page when bomb is exploded
    Given the bomb is exploded
    When I go to the home page
    Then  I should see "Bomb expoloded"
      And I should see "make_new_bomb" link
      And I should not see "activation-code" field
      And I should not see "activate" button
