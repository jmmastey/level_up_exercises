Feature: Admin user can make otherwise restricted changes
  As an admin user
  I want to edit quests
  So that there is a way to fill in quest faction

  Scenario:
    Given I am logged in as an admin
    And a zone with 1 uncompleted quest
    When I visit the zone details page
    Then I should see "Edit Quest"

  Scenario:
    Given I am not logged in as an admin
    And a zone with 1 uncompleted quest
    When I visit the zone details page
    Then I should not see "Edit Quest"