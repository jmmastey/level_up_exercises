Feature: Saving favorite meals
  As a user
  I want to favorite meals
  In order to find them later

  Background:
    Given I have a valid account
    And I am logged in
    And I view a menu item

  Scenario: Adding meal to favorites list
    When I click the favorite button
    Then the menu item should save to my favorites
