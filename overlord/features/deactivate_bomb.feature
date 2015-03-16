Feature: Deactivate Bomb

  Background: Deactivate bomb with correct and incorrect codes

  Scenario: Enter correct deactivation code to deactivate bomb
    Given Bomb is in active state
    When I enter correct deactivation code
    Then Bomb is deactivated

  Scenario: Enter incorrect deactivation code to deactivate bomb
    Given Bomb is in active state
    When I enter incorrect deactivation code
    Then Bomb is in activated state

  Scenario: Enter wrong deactivation code 3 times
    Given Bomb is in active state
    When I enter incorrect deactivation code "1212" 3 times
    Then Bomb is in blast page
