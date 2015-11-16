Feature: Searching merchants
  As a user
  I want to search merchants
  In order to find one close to me

  Background:
    Given I have a valid account
    And I am logged in

  Scenario: Searching for a ZIP with results
    Given I am on the home page
    When I search a matching ZIP
    Then I see the merchants matching that ZIP

  Scenario: Searching from the results page
    Given I am on the merchant index
    When I search a matching ZIP
    Then I see the merchants matching that ZIP

  Scenario: Empty search
    Given I am on the home page
    When I search without a ZIP
    Then I see I must enter a ZIP
