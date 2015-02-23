Feature: Viewing all legislators
  As a user
  I want to see a list of all legislators
  To see which legislators I can add to my favorites

  Scenario: View first page of legislators
    When I click on the "Legislators" link in the header
    Then I am taken to the first page of legislators
    And I see pagination links for the list of legislators

  Scenario: Navigate to second page of legislators
    Given I am at the "Legislators" page
    And I click on the "next" navigation link
    Then I am taken to the second page of legislators

  Scenario: View legislator details
    Given I am at the "Legislators" page
    And I click on a legislator
    Then I am taken to the legislator info page for that legislator
