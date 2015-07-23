Feature: Manage Bomb
  In order to create a bomb
  As a genius contractor
  I want to create and manage the bomb

  Background:
    Given I am on the page

  @javascript
  Scenario: Activate Bomb
    Given the bomb is deactivated
    When I enter the correct activation code
    Then the bomb should be activated
    And the timer should start

  @javascript
  Scenario: Deactivate Bomb
    Given the bomb is activated
    When I enter the correct deactivation code
    Then the bomb should be deactivated
    And the timer should be stopped

  @javascript
  Scenario: Activate Already-Activated Bomb
    Given the bomb is activated
    When I enter an activation code
    Then nothing happens

  @javascript
  Scenario: Enter Incorrect Activation Code
    Given the bomb is deactivated
    When I enter an incorrect activation code
    Then the bomb should be deactivated
    And the timer should be stopped

  @javascript
  Scenario: Enter Incorrect Deactivation Code 3 Times
    Given the bomb is activated
    When I enter an incorrect deactivation code
    And I enter an incorrect deactivation code again
    And I enter an incorrect deactivation code again
    Then the bomb should explode
    And the bomb should be exploded
    And the buttons should be disabled
    And the timer should be stopped

  @javascript
  Scenario: The bomb timer reaches 00:00
    Given the bomb is activated
    When the bomb timer ends
    Then the bomb should explode
    And the bomb should be exploded
    And the buttons should be disabled
    And the timer should be stopped

  @javascript
  Scenario: Invalid Input for Code
    Given the bomb is not exploded
    When I enter an invalid code
    Then I should see "Only Numerical Inputs Allowed"