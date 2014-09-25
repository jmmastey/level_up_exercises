Feature: Bomb Activation
  Scenario: Activate bomb normally
    Given the bomb is not active
    When I send the bomb the code "1234"
    Then the bomb should be active

  Scenario: Try to activate with bad code
    Given the bomb is not active
    When I send the bomb the code "12A4"
    Then the bomb should not be active

  Scenario: Try to activate when the bomb
    is already active
    Given the bomb is active with code "0000"
    When I send the bomb the code "0000"
    Then the bomb shoud throw an error
