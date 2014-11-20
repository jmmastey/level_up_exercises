Feature: Deactivation of the bomb
  As a super villain
  In order to accomodate possible change of mind
  And to make sure the bomb is tamper proof
  I want to have complete control over the deactivation process of the bomb

  @javascript
  Scenario: Initial State
    Given the bomb is activated
    When I go to the home page
    Then I should see deactivate button disabled
      And the bomb should be activated

  @javascript
  Scenario Outline: Insert the activation code
    Given the bomb is activated
      And I am on the home page
    When I fill in "<code>" for "deactivation-code"
    Then I should see deactivate button <status>

    Examples:
    | code | status   |
    | 0000 | enabled  |
    | 7653 | enabled  |
    | 12b4 | disabled |
    | acvx | disabled |
    | #### | disabled |

  @javascript
  Scenario Outline: Try to deactivate the bomb
    Given the bomb is activated
      And I have inserted "<code>" as the deactivation code
    When I press "deactivate"
    Then the bomb should be <status>

    Examples:
    | code | status        |
    | 0000 | deactivated   |
    | 8988 | activated     |
    | 7653 | activated     |

  @javascript
  Scenario: Try to deactivate the bomb with wrong code
    Given the bomb is activated
      And I have tried to deactivate 1 time unsuccesfully
    Then I should see "You have 2 attempts remaining"
      And the bomb should be activated

  @javascript
  Scenario: Try to deactivate the bomb with wrong code too may times
    Given the bomb is activated
      And I have tried to deactivate max times unsuccesfully
    When I try to deactivate unsuccessfully again
    Then I should be on the home page
      And the bomb should be exploded
      And I should see "Let's make a new bomb" link


