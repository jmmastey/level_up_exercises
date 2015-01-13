Feature: search legisltors by geo-location
  In order to find who are my legislators
  As a user
  I want to search legislators by geo-location

  Background:
    Given all legislators for zip code exist
      And I am on search page

  Scenario: Search by zip
    When I search by zip
    Then I should see all legislators for that zip

  Scenario: Search by precise address
    When I search by address in the zip
    Then I should see all legislators for that address only

