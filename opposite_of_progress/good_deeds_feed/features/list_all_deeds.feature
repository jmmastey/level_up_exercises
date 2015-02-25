Feature: Viewing all deeds
  As a user
  I want to see a list of all deeds
  To see what Congress is doing

  Background:
    Given many good deeds exist
    
  Scenario: View first page of good deeds
    Given I am at the good deeds page
    Then I see the first page of good deeds
    And I see pagination links for the list of good deeds
    # And I see links to filter by party

  Scenario: Navigate to second page of legislators
    Given I am at the good deeds page
    And I navigate to the next page of good deeds
    Then I am taken to the second page of good deeds

  Scenario: View good deed details
    Given I am at the good deeds page
    And I click on a good deed
    Then I am taken to the deed details page for that good deed
