Feature: Favorite Artists
  As a user
  I want to see my favorite artists
  In order to see their artworks on my user page

  Scenario: Favorite an artist while logged in
    Given I am logged in and on an artist page
    When I click the Favorite Artist button
    Then I should see the artist on my user page

  Scenario: Favorite an artist while not logged in
    Given I am not logged in and on an artist page
    Then I should not see a Favorite Artist button

  Scenario: Show an Unfavorite Artist link if already favorited
    Given I am logged in and on an artist page I have favorited
    Then I should see a Unfavorite Artist button

  Scenario: Unfavorite an artist while logged in
    Given I am logged in and on an artist page I have favorited
    When I click the Unfavorite Artist button
    Then I should not see the artist on my user page

  Scenario: Unfavorite an artist while not logged in
    Given I am not logged in and on an artist page
    Then I should not see a Unfavorite Artist button

  Scenario: View my favorite artists
    Given I have favorited 2 artists
    Then I should see my favorite artists on my user page
