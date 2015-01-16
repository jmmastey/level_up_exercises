Feature: show a bill
  In order to know the details about a bill
  As a user
  I want to  see the detailed page for a bill

  Scenario: See the bill details
    Given there is a bill
      And I visit that bill's page
    Then I see the official title
      And the details about the bill

  Scenario: See the sponsorships for the bill
    Given there is a bill with sponsorship
      And I visit that bill's page
    Then I see the sponsorships

  Scenario: See the cosponsorships for the bill
    Given there is a bill with cosponsorship
      And I visit that bill's page
    Then I see the cosponsorships

  Scenario: See the actions for the bill
    Given there is a bill with action
      And I visit that bill's page
    Then I see the actions

  Scenario: Clicks sponsoring legislator's link to get to that page
    Given there is a bill with sponsorship
      And I visit that bill's page
    When I click on legislator's name
    Then I should see that legislator's page
