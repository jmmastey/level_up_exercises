Feature: Bomb Detonation
  I am Overlord
  Detonation imminent
  All will pay dearly

  Background:
    Given I am on the home page
    And I have activated the bomb

  @javascript
  Scenario: Detonate the bomb
    When I type "detonate 1"
    And I enter the query
    And I wait for 1 seconds
    And I wait for ajax request to finish
    Then The bomb should be detonated
