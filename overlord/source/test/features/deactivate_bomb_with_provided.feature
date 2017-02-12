Feature: deactivate bomb with provided codes

  @clear_state
  Scenario: boot bomb
    Given an unbooted bomb
    When I boot the bomb with "3333"
    Then the bomb should be deactivated

  Scenario: attempt to activate bomb with provided code
    Given a deactivated bomb
    When I activate the bomb with "3333" and "6666"
    Then the bomb should be activated

  Scenario: attempt to deactivate bomb with provided code
    Given an activated bomb
    When I deactivate the bomb with "6666"
    Then the bomb should be deactivated