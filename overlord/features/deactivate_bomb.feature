Feature: Deactivate the bomb
  As an evil mastermind
  I want to deactivate the bomb
  So it doesnt explode when the ransom is paid

  Scenario: Bomb deactivates with the default code
    Given that the bomb is booted and activated with default codes
    When I try to deactivate the bomb with the default codes
    Then the bomb is deactivated

  Scenario: Bomb does not deactivate if incorrect code is entered once
    Given that the bomb is booted and activated with default codes
    When I try to deactivate the bomb with the wrong code once
    Then the bomb does not explode

  Scenario: Bomb does not deactivate if the incorrect code is entered twice
    Given that the bomb is booted and activated with default codes
    When I try to deactivate the bomb with the wrong code twice
    Then the bomb does not explode

  Scenario: Bomb explodes if the wrong deactivation code is entered 3 times
    Given that the bomb is booted and activated with default codes
    When I try to deactivate the bomb with the wrong code three times
    Then the bomb goes boom