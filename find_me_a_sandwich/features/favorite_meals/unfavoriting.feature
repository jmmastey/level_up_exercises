Feature: Deleting favorite meals
  As a user
  I want to remove favorited meals
  In order clear them from my favorites list

  Background:
    Given I have a valid account
    And I am logged in
    And there are favorited meals in my favorites list

  Scenario: Deleting favorites
    When I click the unfavorite button
    Then the meal should be removed from my favorites list
