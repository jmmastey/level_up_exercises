@vcr
Feature: Get the thumbnail image for an artist
  As a user
  I want to view view the thumbnail image
  In order to get an idea of the artist's style

  Background:
    Given I am on a page for an artist

  Scenario: View the index of artists
    Then I should see a thumbnail image
