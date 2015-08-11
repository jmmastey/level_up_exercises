Feature: Bomb Activation
  As the overlord
  I want to make a customizable bomb
  In order to take over the world

  Scenario: Bomb is not booted
    Given I am viewing "/"
    Then bomb status is "notbooted"

  Scenario: Default Activation code set
    Given I am viewing "/"
    And I set the default codes
    And I enter the "activate" code 1234
    Then bomb status is "booted"

  Scenario: Custom Activation code set
    Given I am viewing "/"
    And I enter the "a_code" code 0000
    And I click "BOOT"
    Then bomb status is "booted"

  Scenario: Activate the bomb using default code
    Given I am viewing "/"
    And I set the default codes
    And I enter the correct default activation code
    Then bomb status is "activated"

  Scenario: Activate the bomb using custom code
    Given I am viewing "/"
    And I set the custom codes
    And I enter the wrong default activation code
    Then bomb status is "activated"
