Feature:
  The bomb will respond to custom settings and will ignore the defaults

  Background:
    Given the user is on the home page
    And there is a new bomb
    And the user submits activation code 5567
    And the user submits deactivation code 0943
    And the user presses boot bomb

  Scenario:
    Then submit code 1234 is invalid
    And the bomb is inactive

  Scenario:
    When the user submits code 5567
    Then submit code 0000 is invalid
    And the bomb is active

  Scenario:
    When the user submits code 5567
    And the user submits code 0943
    Then the bomb is inactive
