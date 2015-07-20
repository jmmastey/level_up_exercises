Ability: Bomb Activation

  As a super-villain
  I need the ability to activate the bomb
  So that I can choose when the bomb will be used

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
