Feature: Viewing good deed info
  As a user
  I want to see a good deed's details
  To see more information about the deed

  Scenario: View good deed show page
    Given a good deed exists
    Given I am at a good deed's page
    Then I see the deed's details
    And I see a link to the deed's sponsor
    And I see a link to search Wikipedia for the deed
