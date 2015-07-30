Feature: Cutting Wire
  In order to allow an alernate way to defuse the bomb
  As a bomb defuser
  I want to be able to cut a wire that would cause the bomb defuse

  Background:
    Given I am on the bomb page
    And the bomb is armed

  Scenario: Cutting the correct wire causes bomb to disarm
    When I cut the correct wire
    Then the bomb should be disarmed

  Scenario: Cutting the incorrect wire cuases the bomb to explode
    When I cut the wrong wire
    Then the bomb state should be exploded