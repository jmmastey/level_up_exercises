Feature: Add or remove legislator from favorites
  As a user
  I want to add or remove legislators from my favorites
  To select which legislators will be included in my email updates

  Background:
    Given a legislator exists
    Given a user exists and is logged in

  Scenario: Find button to add legislator to favorites
    Given I am at a legislator's page
    Then I see a button to add the legislator to my favorites

  Scenario: Add legislator to favorites
    Given I am at a legislator's page
    When I add the legislator to my favorites
    Then I see the legislator in my favorites

  Scenario: Find button to remove legislator from favorites
    Given I am at a legislator's page
    And the legislator is already in my favorites
    Then I see a button to remove the legislator from my favorites

  Scenario: Remove legislator from favorites through legislator's page
    Given the legislator is already in my favorites
    And I am at a legislator's page
    When I remove the legislator from my favorites
    Then the legislator is removed from my favorites

  Scenario: Remove legislator from user's profile page
    Given the legislator is already in my favorites
    And I am at my user profile page
    When I remove the legislator from my favorites through my profile
    Then the legislator is removed from my favorites

  Scenario: Can't add to favorites if logged out
    Given I have logged out of my account
    When I am at a legislator's page
    Then I do not see a button to add the legislator to my favorites
