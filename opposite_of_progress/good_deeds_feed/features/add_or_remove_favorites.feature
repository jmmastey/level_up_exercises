Feature: Add or remove legislator from favorites
  As a user
  I want to add or remove legislators from my favorites
  To select which legislators will be included in my email updates

  Background:
    Given a legislator exists
    Given a user exists and is logged in

  Scenario: Find link to add legislator to favorites
    Given I am at a legislator's page
    Then I see a link to add the legislator to my favorites

  Scenario: Add legislator to favorites
    Given I am at a legislator's page
    When I add the legislator to my favorites
    Then I see the legislator in my favorites

  Scenario: Find link to remove legislator from favorites
    Given I am at a legislator's page
    And the legislator is already in my favorites
    Then I see a link to remove the legislator from my favorites

    Scenario: Remove legislator from favorites through legislator's page
    Given I am at a legislator's page
    And the legislator is already in my favorites
    When I remove the legislator from my favorites
    Then the legislator is removed my favorites