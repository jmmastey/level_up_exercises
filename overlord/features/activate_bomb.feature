Feature: Bomb will activate with the appropriate activation code
  As an evil mastermind
  I want to activate the bomb
  In order to make it go boom

  Scenario: I see the activation options
    Given that the bomb is booted with default codes
    Then I see fields to enter the activation code
    And I see a button to activate the bomb

  Scenario: Bomb was activated with defaults
    Given that the bomb is booted with default codes
    When I enter the default activation code
    And I press the activate button
    Then the bomb is active

  Scenario: Bomb was activated with custom codes
    Given the bomb is booted with "4444"
    When I enter "4444" for the activation code
    And I press the activate button
    Then the bomb is active

  Scenario: Bomb was activated with custom codes, but wrong code is entered
    Given the bomb is booted with "4444"
    When I enter "9999" for the activation code
    And I press the activate button
    Then to bomb warns me that I was wrong
    And it is not activated