Feature: Activate Bomb
  As the almighty overlord
  I want to be able to start it(The rest is a blast(hah))

  Scenario: Initialized Bomb
    Given the bomb is deactivated
    When I go to the home page
    Then I should see the activate button disabled
      And the bomb should be deactivated

  @javascript
  Scenario Outline: Fill in the activation code
    Given I am on the home page
    When I fill in "<code>" for "activation-code"
    Then I should see the activate button <status>

    Examples:
    | code | status   |
    | 4321 | enabled  |
    | 2222 | enabled  |
    | 12b4 | disabled |
    | acvx | disabled |
    | #### | disabled |
    | !@#$ | disabled |
    | 123% | disabled |
    | 123^ | disabled |
    | 123& | disabled |
    | 123* | disabled |
    | 123( | disabled |

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