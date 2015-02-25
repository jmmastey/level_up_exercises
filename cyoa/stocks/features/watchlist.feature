Feature: User can add and remove stocks from their watchlist
  As a user
  I want to add and remove stocks from my watchlist
  In order to create my feed

  Background:
    Given that I am logged in
    And stocks exist

  Scenario: I initially view my empty watchlist
    When I click the watchlist button
    Then I see no stocks on my watchlist

  Scenario: I add a stock to my watchlist from the index page
    Given I am on the index page
    When I click the star next to a stock not already on my watchlist
    Then that stock is added to my watchlist

  Scenario: I remove a stock from my watchlist from the index
    Given I am on the index page
    And I am watching stocks
    When I click the star next to a stock already on my watchlist
    Then that stock is removed from my watchlist

  Scenario: I add a stock to my watchlist from the stock's page
    Given I am on the show page
    And that stock is not on my watchlist
    When I click the watchlist button
    Then that stock is added to my watchlist

  Scenario: I remove a stock to my watchlist from the stock's page
    Given I am on the show page
    And that stock is on my watchlist
    When I click the watchlist button
    Then that stock is removed from my watchlist