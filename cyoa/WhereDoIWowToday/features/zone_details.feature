Feature: Each zone has details about its remaining objectives
  As a user
  I want to see a list of quests and achievements left to do in a zone
  So that I can tell whether it looks fun

  Scenario: Only list the quests not completed by my character
    Given a zone with 1 quest not completed by my character
    And 2 quests not completed by a different character
    When I visit the zone details page
    Then I should see 1 objective

  Scenario: Only list the achievements quests not completed by my character
    Given a zone with 1 achievement not completed by my character
    And 2 achievements not completed by a different character
    When I visit the zone details page
    Then I should see 1 objective

  Scenario: There should be a message if there are no uncompleted quests
    Given a zone with 0 uncompleted quests
    When I visit the zone details page
    Then I should see "No remaining quests"

  Scenario: There should be a message if there are no uncompleted achievements
    Given a zone with 0 uncompleted achievements
    When I visit the zone details page
    Then I should see "No remaining achievements"

  Scenario: Objectives for the other faction should not be listed
    Given a zone with 1 uncompleted objective restricted to the other faction
    When I visit the zone details page
    Then I should see 0 objectives
