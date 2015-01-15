Feature: search legisltors by geo-location
  In order to find who are my legislators
  As a user
  I want to search legislators by geo-location

  Background:
    Given all legislators for zip code 60056 exist
      And I am on search page

  @congress_api
  Scenario: Search by zip
    When I search legislators for 60056
    Then I should see all legislators for 60056

  @congress_api
  Scenario: Search by precise address
    When I search by address in 60056
    Then I should see all legislators for that address

