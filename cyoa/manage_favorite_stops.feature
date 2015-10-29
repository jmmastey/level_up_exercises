Feature: Manage Favorite Stops
  As a commuter
  I want to save or remove bus stops I use frequently
  So that I can see arrival times faster

  Background:
    Given I have a MyCTApp account
    And I login
    And I am on the homepage

  Scenario: Add Favorite Stop
    When I select a bus route, direction, and stop
    And I click the star icon
    And I have been notified that the route has been saved
    Then I should see it in the list of Favorite Routes

#  Scenario: Remove Favorite stop
#    When I have a favorited a route
#    And I select a route from the list of Favorite Routes
#    And I click the star icon
#    And I have been notified that the route has been removed
#    Then I should not see it in the list of Favorite Routes
