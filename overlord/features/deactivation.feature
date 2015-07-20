Ability: Bomb Deactivation

  As a super-villain
  I need the ability to deactivate the bomb
  So that I can change my mind if my demands are met

  @javascript
  Scenario: Bombs have a default deactivation code
    Given an activated bomb
    When the default deactivation code "0000" is entered
    Then the bomb will display as inactive

  @javascript
  Scenario: Bombs will not deactivate with incorrect deactivation codes
    Given an activated bomb
    When an incorrect deactivation code is entered
    Then the bomb will display as active
    And the display indicates the deactivation code was incorrect

  @javascript
  Scenario Outline: Bombs cannot be deactivated with invalid deactivation codes
    Given an activated bomb
    When an invalid deactivation <code> is entered
    Then the bomb will display as active
    And the display indicates the deactivation code was invalid

    Examples:
      | code   |
      | ""     |
      | "aaaa" |
      | "1ab3" |
      | "12"   |
