Feature: The bomb has wires that can be snipped to keep the bomb from exploding
  In order to stop the delinquent customer from profiting off of my work
  As an unpaid bomb builder
  I want to snip some wires to keep the bomb from exploding

  Scenario: A disabled bomb doesn't explode
    Given a disabled active bomb
    When an explosion is triggered
    Then the bomb is not exploded

  Scenario Outline: Cutting the wires disables the bomb
    Given an <status> bomb
    When I cut the wires
    Then the bomb is disabled

    Examples:
      | status   |
      | active   |
      | inactive |

  Scenario Outline: Cutting the wires does not change the activation status
    Given an <status> bomb
    When I cut the wires
    Then the "status" field should contain "<status>"

    Examples:
      | status   |
      | active   |
      | inactive |

  Scenario: The timer does not give away my change
    Given an active bomb with timer at "00:54:32"
    When I cut the wires
    Then 2 seconds later the "countdown" field should contain "00:54:30"