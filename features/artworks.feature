Feature: Artworks Page
  As a user
  I want to view an artist's artworks
  In order to see that they have produced

  Background:
    Given I am on the page for an artwork

  Scenario: Go to the artwork page
    Then I should see the artwork
