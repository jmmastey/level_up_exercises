Feature: Bomb Activation
  In order to explode a bomb
  As a villian
  I want to be able to activate a bomb

  Scenario: Activate a bomb
    Enter in an activation code to set the status of the bomb to active
    Given there is a bomb
    When I click the activate button
    And enter in the correct activation code
    Then I expect to see the timer count down
    And the status to equal ARMED

  Scenario: Activate a bomb with invalid code
    Enter in an invalid activation code
    Given there is a bomb
    When I click the activate button
    And enter in the incorrect activation code
    Then I should see an invalid code error message
    And the status to equal INACTIVE
