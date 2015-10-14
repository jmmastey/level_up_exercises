Feature: List the number of each type of objective available in each zone
  As a user
  I want to see a list of zones with objective counts
  So that I can tell which zones are most likely to be interesting 

  Scenario:
    Given there are multiple zones
    When I request information for my character
    Then I should see a row for each zone

    Given a zone with 3 uncompleted quests
    When I request information for my character
    Then the zone's row should specify 3 quests

    Given a zone with 0 uncompleted quests
    When I request information for my character
    Then the zone's row should specify 0 quests

    Given a zone with 1 uncompleted quest
    When I click the zone name in the zone summaries
    Then I should see the zone's details