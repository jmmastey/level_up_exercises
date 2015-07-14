Feature: Custom Bomb
  Background:
    Given I have a new bomb
    And set activation key to "5567"
    And set deactivation key to "0943"
    And I booted the bomb

  Scenario:
    Then submit code "1234" fails (invalid)

  Scenario:
    Given I submit code "5567"
    Then submit code "0000" fails (invalid)

  Scenario:
    Given I submit code "1234"
    Then the bomb is inactive

  Scenario:
    Given I submit code "5567"
    And I submit code "0000"
    Then the bomb is active

  Scenario:
    Given I submit code "5567"
    And I submit code "0943"
    Then the bomb is inactive
