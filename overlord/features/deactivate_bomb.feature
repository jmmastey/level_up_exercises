Feature: Deactivate Bomb

  Scenario: Deactivate bomb with correct deactivation code
    Given Bomb is in active state
    When I enter correct deactivation code
    Then Bomb is deactivated

  Scenario: Deactivate bomb with incorrect deactivation code
    Given Bomb is in active state
    When I enter incorrect deactivation code
    Then Bomb is in activated state

  Scenario: Enter wrong deactivation code 3 times
    Given Bomb is in active state
    When I enter incorrect deactivation code "1212" 3 times
    Then Bomb is in blast page
