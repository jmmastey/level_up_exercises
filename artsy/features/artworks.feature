Feature: Artworks Page
  As a user
  I want to view an artist's artworks
  In order to see that they have produced

  Background:
    Given I am logged in

  Scenario: View all the artworks for an artist
    Given I am on a page for an artist with an artwork
    When I click on View All Artworks
    Then I should see the artist's artworks

  Scenario: Go to an individual artwork page
    Given I am on the page for an individual artwork
    Then I should see the artwork

  Scenario: Create a valid new artwork
    Given I am on an artist's artworks page
    When I create a new artwork: Nighthawk
    Then I should be on the artwork page for Nighthawk
    And I should see a message confirming the artwork was created

  Scenario: Create an invalid new artwork
    When I create an invalid artwork
    Then I should see artwork validation errors

  Scenario: Update an artist with valid attributes
    When I edit an artwork: Nighthawk
    And I update the title to Rainy Day in Paris
    Then I should be on the artwork page for Rainy Day in Paris
    And I should see a message confirming the artwork was updated

  Scenario: Update an artist with invalid attributes
    When I edit an artwork with invalid data: Nighthawk
    Then I should see artwork validation errors

  Scenario: Delete an artwork
    When I delete the artwork: Nighthawk
    Then I should not see Nighthawk on the artworks page for the artist
    And I should see a message confirming the artwork was deleted
