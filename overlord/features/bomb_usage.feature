Feature: Bomb Usage

  As a super-villain
  I need the bomb to have a countdown timer
  So that I can avoid having the bomb detonate immediately upon activation

  As a super-villain
  I need the ability to activate the bomb
  So that I can choose when the bomb will be used

  As a super-villain
  I need the ability to deactivate the bomb
  So that I can change my mind if my demands are met

  @javascript
  Scenario: Bombs can be activated
    Given a provisioned bomb
    When the bomb is activated
    Then the bomb will display as active
    And the timer will start counting down

  @javascript
  Scenario: Bombs can be deactivated
    Given an activated bomb
    When the bomb is deactivated
    Then the bomb will display as inactive
    And the timer will stop counting down

  @javascript
  Scenario: Bombs can be activated with custom activation codes
    Given a provisioned bomb with a custom activation code
    When the bomb is activated with the custom activation code
    Then the bomb will display as active
    And the timer will start counting down

  @javascript
  Scenario: Bombs can be deactivated with custom deactivation codes
    Given a provisioned bomb with a custom deactivation code
    When the bomb is deactivated with the custom deactivation code
    Then the bomb will display as inactive
    And the timer will stop counting down

  @javascript
  Scenario: Bombs can be activated with a custom countdown value
    Given a provisioned bomb with a custom countdown value
    Then the countdown timer will be set to the custom countdown value

  @javascript
  Scenario Outline: Bombs cannot be activated with invalid activation codes
    Given a provisioned bomb
    When an invalid activation <code> is entered
    Then the bomb will display as inactive
    And the bomb display indicates the activation code was invalid

    Examples:
      | code   |
      | ""     |
      | "aaaa" |
      | "1ab3" |
      | "12"   |

  @javascript
  Scenario Outline: Bombs cannot be deactivated with invalid deactivation codes
    Given an activated bomb
    When an invalid deactivation <code> is entered
    Then the bomb will display as active
    And the bomb display indicates the deactivation code was invalid

    Examples:
      | code   |
      | ""     |
      | "aaaa" |
      | "1ab3" |
      | "12"   |


  @javascript
  Scenario: Bombs cannot be activated with incorrect activation codes
    Given a provisioned bomb
    When an incorrect activation code is entered
    Then the bomb will display as inactive
    And the bomb display indicates the activation code was incorrect

  @javascript
  Scenario: Bombs cannot be deactivated with incorrect deactivation codes
    Given an activated bomb
    When an incorrect deactivation code is entered
    Then the bomb will display as active
    And the bomb display indicates the deactivation code was incorrect

  @javascript
  Scenario: Bombs will detonate after three unsuccessful deactivation attempts
    Given an activated bomb
    When an incorrect deactivation code is entered three times
    Then the bomb will detonate
