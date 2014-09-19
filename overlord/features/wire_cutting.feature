Feature: Wire-cutting
  As a person
  I want to cut wires
  In order to disarm the bomb

  Background: A bomb has been booted
    Given I have booted a bomb with the default codes

  @javascript
  Scenario: Cutting disarm wires
    When I cut all disarm wires
    Then the bomb should be disabled

  @javascript
  Scenario: Cutting an exploding wire
    Given the bomb is active
    When I cut an exploding wire
    Then the bomb should explode

  @javascript
  Scenario: Activating a bomb ready to explode
    When I cut an exploding wire
    And I enter the code 1234
    Then the bomb should explode
