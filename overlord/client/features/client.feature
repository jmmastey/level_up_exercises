Feature:
  This client utility will allow a given user to monitor the status of a
  remote bomb and communicate with it.

  Background:
    Given the user is on the home page
    And the user presses reset

  Scenario:
    Then the user should see the bomb state
