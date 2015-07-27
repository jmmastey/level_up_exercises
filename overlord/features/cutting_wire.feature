Feature: Cutting Wire
  In order to allow an alernate way to defuse the bomb
  As a bomb defuser
  I want to be able to cut a wire that would cause the bomb defuse

  Scenario: Cutting the correct wire causes bomb to reset back to activation state
    Given I am on the bomb page
    And the bomb is armed
    When I cut the correct wire
    Then the bomb state should be activation

  Scenario: Cutting the incorrect wire cuases the bomb to explode
    Given I am on the bomb page
    And the bomb is armed
    When I cut the wrong wire
    Then the bomb state should be exploded