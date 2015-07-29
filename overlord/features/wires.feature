Feature: The bomb has wires that can be snipped to keep the bomb from exploding
  In order to stop the delinquent customer from profiting off of my work
  As an unpaid bomb builder
  I want to snip some wires to disable the bomb

  Scenario Outline: Cutting the wires disables the bomb
    Given an <status> bomb
    When I cut the wires
    Then the bomb is disabled

    Examples:
      | status   |
      | active   |
      | inactive |
