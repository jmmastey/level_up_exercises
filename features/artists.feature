Feature: Artists Page
  As a user
  I want to view the artists page
  In order to manage artists I can follow

  Background:
    Given I have 5 artists
    And I am on the artists page

  Scenario: View the index of artists
    Then I should see the artist: Monet
    And I should see the artist: Manet
    And I should see the artist: Van Gogh
    And I should see the artist: Picasso
    And I should see the artist: Hopper
