Feature: Favorite Artists
  As a user
  I want to see my favorite artists
  In order to see their artworks on my user page

  Background:
    Given I have favorited 2 artists

  Scenario: View my favorite artists
    Then I should see my favorite artists on my user page
