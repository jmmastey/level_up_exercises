Feature: Toggle visibility of quests
  As a user
  I want to hide and unhide objectives
  So that I can ignore objectives that I don't want to consider

  Scenario: I should be able to hide objectives
    Given a zone with 3 uncompleted quests
    And I visit the zone details page
    When I hide a quest
    Then I should see 2 objectives

  Scenario: I should be able to unhide objectives
    Given 1 visible quest and 1 hidden quest
    When I show all quests
    Then I should see 2 objectives
