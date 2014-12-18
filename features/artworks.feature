Feature: Artworks Page
  As a user
  I want to view an artist's artworks
  In order to see that they have produced

  Scenario: View all the artworks for an artist
    Given I am on a page for an artist with an artwork
    When I click on View All Artworks
    Then I should see the artist's artworks

  Scenario: Go to the artwork page
    Given I am on the page for an artwork
    Then I should see the artwork

