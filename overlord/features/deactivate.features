Feature: Bomb Deactivation Tries
  Background:
    Given I can see the unbooted bomb
      And I boot the bomb with default codes
      And I activate the bomb

  Scenario: Activate and fail
     When I enter 1111
     Then the bomb warns me that I made a mistake

  Scenario: Activate and fail then succeed
     When I enter 1111
      And I enter the default deactivation code
     Then the bomb is not activated

  Scenario: Activate and fail twice
     When I enter 1111
      And I enter 1111
     Then the bomb warns me that I made a mistake

  Scenario: Activate and fail twice then succeed
     When I enter 1111
      And I enter 1111
      And I enter the default deactivation code
     Then the bomb is not activated

  Scenario: Activate and fail three times
     When I enter 1111
      And I enter 1111
      And I enter 1111
     Then the bomb blows up
