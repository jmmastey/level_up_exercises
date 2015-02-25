Feature: User can navigate through the app
  As a user
  I want to be able to see stock detail
  In order to make an educated buying decision

  Scenario: I visit the detail page for a stock
    Given I am on the index page
    And stocks exist
    When I click on a stock
    Then I am taken to that stock's detail page

  Scenario: I visit the index page from anywhere
    Given stocks exist
    And I am on a stock's detail page
    When I click the stocks button
    Then I am taken to the index page

  Scenario: I visit the watchlist
    Given that I am logged in
    When I click the watchlist button
    Then I am taken to the watchlist page