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
    Then submit code "1234" fails (not booted)

  Scenario:
    Then set activation code to "0123" succeeds

  Scenario:
    Then set deactivation code to "9999" succeeds
