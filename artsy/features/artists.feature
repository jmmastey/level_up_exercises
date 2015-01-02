Feature: Artists Page
  As a user
  I want to view the artists page
  In order to manage artists I follow

  Background:
    Given I have 2 artists
    And I am logged in
    And I am on the artists page

  Scenario: View the index of artists
    Then I should see all the artists

  Scenario: View the index of artists
    Given I am on a page for an artist
    Then I should see a thumbnail image

  Scenario: View an individual artist
    When I click on Claude Monet
    Then I should be on the artist page for Monet

  Scenario: Create a valid new artist
    When I create a new artist: Henri Matisse
    Then I should be on the artist page for Henri Matisse
    And I should see a message confirming the artist was created

  Scenario: Create an invalid new artist
    When I create an invalid artist
    Then I should see artist validation errors

  Scenario: Update an artist with valid attributes
    When I edit an artist: Claude Monet
    And I update the last name to Painter
    Then I should be on the artist page for Claude Painter
    And I should see a message confirming the artist was updated

  Scenario: Update an artist with invalid attributes
    When I edit an artist with invalid data: Claude Monet
    Then I should see artist validation errors

  Scenario: Delete an artist
    When I delete the artist: Claude Monet
    Then I should not see Claude Monet on the Artists page
    And I should see a message confirming the artist was deleted
