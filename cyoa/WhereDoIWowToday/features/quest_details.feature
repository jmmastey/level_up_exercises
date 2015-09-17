Feature: Detailed quest information
  As a user
  I want to see detailed information about uncompleted quests
  So that I can do the quest if it looks interesting
  
  Scenario: Click on a quest for more info
    Given a zone with 1 quest not completed by my character
    When I visit the zone details page
    And I click on the quest
    Then I should see the quest's details
