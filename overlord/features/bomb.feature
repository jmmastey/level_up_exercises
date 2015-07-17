Feature: Bomb

  As a super-villain bent on dominating the world's information history
  I need an eigenstate-selecting temporal dispersion Internet bomb
  so that I can destroy online information across all probable time-lines.

  Scenario: A newly booted bomb is not active
    When a bomb is booted for the first time
    Then the bomb will display as inactive

  @javascript
  Scenario: Bombs can be activated with valid activation codes
    Given a newly booted bomb
    When entering a valid activation code
    Then the bomb will display as active

  @javascript
  Scenario Outline: Bombs cannot be activated with invalid activation codes
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
  Scenario: Bombs can be deactivated with valid deactivation codes
    Given an active bomb
    When a valid deactivation code is entered
    Then the bomb will display as inactive

  @javascript
  Scenario Outline: Bombs cannot be deactivated with invalid deactivation codes
    Given an active bomb
    When an invalid deactivation <code> is entered
    Then the bomb will display as active
    And the display indicates the deactivation code was invalid

    Examples:
      | code   |
      | ""     |
      | "aaaa" |
      | "12"   |
