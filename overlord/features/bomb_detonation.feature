Feature: Bomb Detonation
  I am Overlord
  Detonation imminent
  All will pay dearly

  Background:
    Given I am on the home page
    And I should see "Bomb is inactive"

  @javascript
  Scenario: Activate and detonate the bomb
    And  I fill in ".query-input" with "activate 1234"
    And I press "Submit Query"
    And I wait for ajax request to finish
    And  I should see "Bomb is active"
    And  I fill in ".query-input" with "detonate 3"
    When I press "Submit Query"
    And I wait for ajax request to finish
    And  I should see "Detonation in 3 seconds"
    And I wait for 3 seconds
    Then I should see "Detonation... done!" within ".console"
