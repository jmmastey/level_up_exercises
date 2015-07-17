Feature:
  This client utility will allow a given user to monitor the status of a
  remote bomb and communicate with it.

  Background:
    Given the user is on the home page
    And there is a new bomb

  Scenario:
    Then the bomb is off

  Scenario:
    Then the user should see the bomb state
    And the bomb state is valid

  Scenario:
    When the user presses boot bomb
    Then the bomb is booted

  Scenario:
    When the user submits activation code 5432
    Then the activation code will be 5432

  Scenario:
    When the user submits deactivation code 2323
    Then the deactivation code will be 2323

  Scenario:
    Then the user should see the time
    And the time is 0:00
