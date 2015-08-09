Feature: Activity Feed
  As a user
  I want to have a running feed of the activities on my profile

  Background:
    Given I am authenticated
    And I am on my profile page

  Scenario: Add a new anime to activity feed
    When I add a new anime <anime>
    And I am on my profile page
    Then I should see my activity feed saying I added <anime>