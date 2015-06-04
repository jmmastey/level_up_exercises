
Feature: Activate the bomb
  In order potentially blow myself up
  As the user
  I want to activate a booted bomb

  Scenario: Activate bomb
    Given the bomb is booted
    When I enter 1234 
    Then I see the countdown start
    And the bomb is activated message

  Scenario: Fail to activate bomb
    Given the bomb is booted
    When I submit the wrong activation code
    Then I see a wrong code error message

