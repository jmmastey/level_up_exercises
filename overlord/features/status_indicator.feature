Feature: Status Indicator
  In order to determine the current status of the bomb
  As a bomber
  I want to be able to view the current status of the bomb

  @javascript
  Scenario: View the status of an inactive bomb
    Given I am viewing an inactive bomb
    Then the bomb is inactive

  @javascript
  Scenario: View the status of an inactive bomb
    Given I am viewing an active bomb
    Then the bomb is active

  @javascript
  Scenario: View the status of an exploded bomb
    Given I am viewing an exploded bomb
    Then the bomb is exploded