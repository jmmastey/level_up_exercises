Feature: Default Bomb
  Background:
    Given I have a new bomb
    And I booted the bomb

  Scenario: Cannot change once booted
    Then set activation key to "0000" fails

  Scenario: Cannot change once booted
    Then set deactivation key to "0000" fails

  Scenario:
    Then the time is "0:00"

  Scenario:
    Given I submit code "1234"
    Then the bomb is active
    And the time is "2:00"

  Scenario:
    Given I submit code "1234"
    And I submit code "0000"
    Then the bomb is inactive

  Scenario: 1 mistake is okay
    Given I submit code "1234"
    And I submit code "5555"
    Then the bomb is active

  Scenario: 1 mistake is okay
    Given I submit code "1234"
    And I submit code "5555"
    And I submit code "0000"
    Then the bomb is inactive

  Scenario: 2 mistakes is okay
    Given I submit code "1234"
    And I submit code "5555"
    And I submit code "5555"
    Then the bomb is active

  Scenario: 2 mistakes is okay
    Given I submit code "1234"
    And I submit code "5555"
    And I submit code "5555"
    And I submit code "0000"
    Then the bomb is inactive

  Scenario: 3 mistakes is bad
    Given I submit code "1234"
    And I submit code "5555"
    And I submit code "5555"
    And I submit code "5555"
    Then the bomb is exploded
