Feature: Goal list ownership
  As a user
  I want to be the only one who can interact with my goal list
  So that other users do not interfere with my planning
  
  Scenario: A goal list should belong to a user
    Given I am logged in as a normal user
    And a goal list with 2 objectives
    When I log in as a different user
    And I visit the zone details page
    Then the goal list should contain 0 objectives

  Scenario: A goal list should persist across sessions
    Given I am logged in as a normal user
    And a goal list with 2 objectives
    When I log in as the same user
    And I visit the zone details page
    Then the goal list should contain 2 objectives
