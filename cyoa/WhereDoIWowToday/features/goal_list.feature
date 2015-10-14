Feature: A goal list for zone objectives
  As a user
  I want to make a goal list for a zone
  So that I can plan which objectives to do

  Scenario: It should be possible to create a goal list by adding an objective
    Given I am logged in as a normal user
    And a zone with 2 uncompleted quests
    And I visit the zone details page
    When I add a quest to the goal list
    Then the goal list should contain 1 objective

  Scenario: A quest added to the goal list should only appear on the page once
    Given I am logged in as a normal user
    And a zone with 2 uncompleted quests
    And I visit the zone details page
    When I add a quest to the goal list
    Then I should see 1 objective

  Scenario: I should be able to add a quest to an existing goal list
    Given I am logged in as a normal user
    And a goal list with 1 objective
    When I add a quest to the goal list
    Then the goal list should contain 2 objectives

  Scenario: I should be able to remove an objective from an existing goal list
    Given I am logged in as a normal user
    And a goal list with 2 objectives
    When I remove an objective from the goal list
    Then the goal list should contain 1 objective

  Scenario: An objective removed from a goal list should still be on the page
    Given I am logged in as a normal user
    And a goal list with 2 objectives
    When I remove an objective from the goal list
    Then I should see the removed objective

  Scenario: Newly added items should go at the end of the list
    Given I am logged in as a normal user
    And a goal list with 2 objectives
    When I add a quest to the goal list
    Then the new objective should be at the end of the goal list
