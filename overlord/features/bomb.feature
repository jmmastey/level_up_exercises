Feature: Bomb

  As a super-villain bent on dominating the world's information history
  I need an eigenstate-selecting temporal dispersion Internet bomb
  so that I can destroy online information across all probable time-lines.

  Scenario: A newly booted bomb is not active
    When a bomb is booted for the first time
    Then the bomb will display as inactive

  @javascript
  Scenario: Bombs have a default activation code
    Given a newly booted bomb
    When the default activation code "1234" is entered
    Then the bomb will display as active

  @javascript
  Scenario: Bombs will not activate with incorrect activation codes
    Given a newly booted bomb
    When an incorrect activation code is entered
    Then the bomb will display as inactive
    And the display indicates the activation code was incorrect

  @javascript
  Scenario Outline: Bombs will not activate with invalid activation codes
    Given a newly booted bomb
    When an invalid activation <code> is entered
    Then the bomb will display as inactive
    And the display indicates the activation code was invalid

    Examples:
      | code   |
      | ""     |
      | "aaaa" |
      | "1ab3" |
      | "12"   |

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
