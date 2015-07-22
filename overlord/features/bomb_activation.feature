Feature: Bomb Activation
  In order to explode a bomb
  As a villian
  I want to be able to activate a bomb

  Background:
    Given there is a bomb
    And I click the activate button

  Scenario: Activate a bomb
    Enter in an activation code to set the status of the bomb to active
    When I enter in the correct activation code
    Then I expect to see the timer count down
    And the status to equal ARMED

  Scenario: Activate a bomb with invalid code
    Enter in an invalid activation code
    When I enter in the incorrect activation code
    Then I should see an invalid code error message
    And the status to equal INACTIVE

  Scenario: Activation button should disable after bomb is activated
    When I enter in the correct activation code
    Then the activation button should not work