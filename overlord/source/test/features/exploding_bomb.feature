Feature: deactivate bomb with incorrect code

  @clear_state
  Scenario: boot bomb
    Given an unbooted bomb
    When I boot the bomb
    Then the bomb should be deactivated

  Scenario: attempt to activate bomb with incorrect code
    Given a deactivated bomb
    When I activate the bomb with "4321"
    Then the bomb should remain deactivated

  Scenario: attempt to activate bomb with correct code
    Given a deactivated bomb
    When I activate the bomb with "1234"
    Then the bomb should be activated

  Scenario: attempt to deactivate the bomb 3 times with the incorrect code
    Given an activated bomb
    When I attempt to deactivate the bomb with "0001"
    And I attempt to deactivate the bomb with "0002"
    And I attempt to deactivate the bomb with "0003"
    Then an "Overlord::ExplosiveError" should have been raised
    And the bomb should have exploded