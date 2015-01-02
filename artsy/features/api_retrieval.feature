@vcr
Feature: Get the thumbnail image for an artist
  As a user
  I want to view view the thumbnail image
  In order to get an idea of the artist's style

  Background:
    Given I am an admin
    And I am on the artists page

  Scenario: Add a new artist from API
    When I manually add an artist
    Then I should see a message confirming the artist was created
    And the artist should have associated artworks

  Scenario: Add an existing artist from API
    When I manually add an existing artist
    Then I should see a message stating the artist exists

  Scenario: Add an artist from API that does not exist
    When I manually add a non-existent artist
    Then I should see a message stating the artist does not exist
