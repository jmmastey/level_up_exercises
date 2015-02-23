Feature: Add or remove legislator from favorites
  As a user
  I want to add or remove legislators from my favorites
  To select which legislators will be included in my email updates

  Scenario: View legislator show page
    Given I am at a legislator's page
    And the legislator is not in my favorites
    Then I see a link to add the legislator to my 