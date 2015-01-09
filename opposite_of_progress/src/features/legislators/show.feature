Feature: Legislator page
  In order to see the details about a legislator
  As as user
  I want to see the page of that legislator

  Background:
    Given a legislator exists


  Scenario:
    When I visit that legislator's page
    Then I see the details about that legislator
      And I see the picture of that legislator

  Scenario:
    Given legislator has previous sponsoships and cosponsorships
    When I visit that legislator's page
    Then I should see cosponsorships
      And I should see sponsorships
