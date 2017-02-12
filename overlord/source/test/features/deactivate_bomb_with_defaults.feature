Feature: deactivate bomb with default codes

  @clear_state
  Scenario: boot bomb without params
    Given an unbooted bomb
    When I boot the bomb
    Then the bomb should be deactivated

  Scenario: activate bomb with default code
    Given a deactivated bomb
    When I activate the bomb with "1234"
    Then the bomb should be activated

  Scenario: attempt to deactivate bomb with default code
    Given an activated bomb
    When I deactivate the bomb with "0000"
    Then the bomb should be deactivated