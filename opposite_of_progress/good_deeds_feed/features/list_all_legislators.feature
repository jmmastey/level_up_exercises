Feature: Viewing all legislators
  As a user
  I want to see a list of all legislators
  To see which legislators I can add to my favorites

  Background:
    Given many legislators exist
    
  Scenario: View first page of legislators
    Given I am at the "legislators" page
    Then I see the first page of legislators
    And I see pagination links for the list of legislators
    And I see links to filter by party

  Scenario: View legislator details
    Given I am at the "legislators" page
    And I click on a legislator
    Then I am taken to the legislator info page for that legislators
