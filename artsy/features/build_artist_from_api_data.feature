Feature: Artists Page
  As the background job
  I want to request artist data via a JSON API
  In order to add artist data to my application

  Scenario: Get artist data
    Given I request artist data from the API for Andy Warhol
    When I visit the artists page
    Then Andy Warhol appears on the artists page

  Scenario: Get artist data with an unusual last name
    Given I request artist data from the API for Vincent van Gogh
    When I visit the artists page
    Then Vincent van Gogh appears on the artists page

