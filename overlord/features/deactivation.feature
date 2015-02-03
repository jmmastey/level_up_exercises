Feature: Deactivation of the bomb
  As the one and only mastermind
  In order to stop the bomb if my cape gets stuck
  I want to be able to stop the bomb

  @javascript
  Scenario Outline: Insert the activation code
    Given the bomb is activated
      And I am on the home page
    When I fill in "<code>" for "deactivation-code"
    Then I should see the deactivate button <status>

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
  Scenario: Try to deactivate the bomb with wrong code too may times
    Given the bomb is activated
      And I have tried to deactivate max times unsuccesfully
    When I try to deactivate unsuccessfully again
    Then I should be on the home page
      And the bomb should be exploded
      And I should see "Start up a new bomb" link