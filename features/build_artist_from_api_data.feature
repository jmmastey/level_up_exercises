Feature: Artists Page
  As the background job
  I want to request artist data via a JSON API
  In order to add artist data to my application

  Scenario: Get artist data
    Given a artist search parameter
    When I request artist data from the API
    Then the new artist appears on the artists page
