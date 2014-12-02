Feature: View the home page
  As a User
  I want to be able to view the home page
  In order to view the lastest news from the art world

  Scenario: List latest shows
    Given some shows
    When I visit the shows page
    Then I should see show names
