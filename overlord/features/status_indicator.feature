Feature: Bomb status is obvious
  In order to threaten the city without blowing myself up
  As a super villian
  I want to know whether my bomb is active or inactive

  Scenario Outline: I can tell the bomb is active
    Given an <state> bomb
    Then the "status" field should contain "<state>"

    Examples:
      | state    |
      | active   |
      | inactive |

  Scenario: I can tell the bomb has exploded
    Given an exploded bomb
    Then there is nothing but a pile of rubble