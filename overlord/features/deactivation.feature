Feature: Bomb Deactivation

  Scenario: Bomb is deactivated on boot
    When the bomb is first booted
    Then the bomb should be in a Deactivated state

  Scenario: Deactivate bomb with default key
    Given that the bomb is booted
    And the bomb has been activated
    When I enter the default deactivation code
    Then the bomb should be in a Deactivated state

  Scenario: Deactivation key must be valid
    When I enter an invalid deactivation code
    Then I should see a "Deactivation Code must be a 4-digit number" error

  Scenario: Deactivate bomb with custom key
    Given that the bomb is booted with a custom deactivation key
    And the bomb has been activated
    When I enter the custom deactivation code
    Then the bomb should be in a Deactivated state

  Scenario: Explosion
    Given that the bomb is booted
    And the bomb has been activated
    When I enter the incorrect deactivation code 3 times
    Then the bomb should be in a Exploded state
    And the bomb overview page should not be responsive

  Scenario: Deactivating when deactivated has no additional effect
    Given that the bomb is booted
    When I enter the default deactivation code
    Then the bomb should be in a Deactivated state
