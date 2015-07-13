Feature: Brand New Bomb
  Background:
    Given I have a new bomb

  Scenario:
    Then I should see an unbooted bomb

  Scenario:
    When I boot the bomb
    Then the bomb is inactive

  Scenario:
    Then the time is "0:00"

  Scenario:
    Then submit code "1234" fails

  Scenario:
    Then set activation key to "0123" succeeds

  Scenario:
    Then set deactivation key to "9999" succeeds
