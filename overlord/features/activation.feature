Feature: Activation of the bomb
  As a super villain
  In order to blast everything imaginable
  I want to have complete control over the activation process of the bomb

  Scenario: Initial State
    Given the bomb is deactivated
    When I go to the home page
    Then I should see activate button disabled
      And the bomb should be deactivated

  @javascript
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
    | #### | disabled |

  @javascript
  Scenario Outline: Try to activate the bomb
    Given I have inserted "<code>" as the activation code
    When I press "activate"
    Then I should be on the home page
      And the bomb should be <status>

    Examples:
    | code | status      |
    | 1234 | activated   |
    | 8988 | deactivated |
    | 7653 | deactivated |

