Feature: Viewing legislator info
  As a user
  I want to see a legislator's info
  To see their congressional details and good deeds

  Scenario: View legislator show page
  	Given a legislator exists
    When I visit that legislator's page
    Then I should see the legislator's details
    And I should see a list of their good deeds
