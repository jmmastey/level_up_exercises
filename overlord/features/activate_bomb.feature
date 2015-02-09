Feature: Bomb will activate with the appropriate activation code
  As an evil mastermind
  I want to activate the bomb
  In order to make it go boom@

  Background:
    Given that the bomb is booted

  Scenario: I see the activation options
    Then I see fields to enter the activation/deactivation codes
    And I see a button to activate the bomb

  Scenario: Bomb was activated with defaults
    When I enter "1111" for the activation code
    And I press the activate button
    Then the bomb is active

  Scenario: Bomb was activated with custom codes
    When I enter "4444" for the activation code
    And I press the activate button
    Then the bomb is active

  Scenario: Bomb was activated with custom codes, but wrong code is entered
    When I enter "abcs" for the activation code
    And I press the activate button
    Then to bomb warns me that I was wrong
    And it is not activated