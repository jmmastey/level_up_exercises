Feature:
  Default Bomb Interactions

  Background:
    Given the user is on the home page
    And there is a new bomb
    And the user presses boot bomb

  Scenario:
    When the user submits deactivation code 1234
    Then the deactivation code fails

  Scenario:
    When the user submits activation code 5432
    Then the activation code fails

  Scenario:
    When the user submits code 1234
    Then the bomb is active
    And the time is 2:00

  Scenario:
    When the user submits code 1234
    And the user submits code 0000
    Then the bomb is inactive

  Scenario: 1 miss is okay
    When the user submits code 1234
    And the user submits code 0391
    Then the bomb is active

  Scenario: 1 miss and then a correct code defuses the bomb
    When the user submits code 1234
    And the user submits code 0391
    And the user submits code 0000
    Then the bomb is inactive

  Scenario: 2 misses is okay
    When the user submits code 1234
    And the user submits code 0391
    And the user submits code 1236
    Then the bomb is active

  Scenario: 2 misses and a correct code defuses it
    When the user submits code 1234
    And the user submits code 0391
    And the user submits code 1236
    And the user submits code 0000
    Then the bomb is inactive

  Scenario: 3 mistakes causes the bomb to explode
    When the user submits code 1234
    And the user submits code 0391
    And the user submits code 1236
    And the user submits code 5253
    Then the bomb is exploded
