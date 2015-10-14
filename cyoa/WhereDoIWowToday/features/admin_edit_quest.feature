Feature: Admin user can make otherwise restricted changes
  As an admin user
  I want to edit quests
  So that I can update missing or incorrect data

  Scenario: Admin should be able to edit quest from zone details page
    Given I am logged in as an admin
    And a zone with 1 uncompleted quest
    When I visit the zone details page
    Then I should see "Edit quest"

  Scenario: Admin should be able to edit quest from quest details page
    Given I am logged in as an admin
    And a zone with 1 uncompleted quest
    When I visit the quest details page
    Then I should see "Edit quest"

  Scenario: Admin should be able to add categories
    Given I am logged in as an admin
    And there are multiple zones
    And a zone with 1 uncompleted quest
    When I submit a new category for a quest
    And I visit the quest details page
    Then I should see the new category
    And I should see the old category

  Scenario: Normal user should not be able to edit quest from zone details page
    Given I am logged in as a normal user
    And a zone with 1 uncompleted quest
    When I visit the zone details page
    Then I should not see "Edit quest"

  Scenario: Normal user should not be able to edit quest quest details page
    Given I am logged in as a normal user
    And a zone with 1 uncompleted quest
    When I visit the quest details page
    Then I should not see "Edit quest"
