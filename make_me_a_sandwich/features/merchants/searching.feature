Feature: Searching merchants
  As a user
  I want to search merchants
  In order to find one close to me

  Background:
    Given some merchants exist
    And I have a valid account
    And I am logged in

  Scenario: Searching for a ZIP with results
    Given I am on the home page
    When I search a matching ZIP
    Then I see the merchants matching that ZIP
    And I do not see the merchants not matching that ZIP

  Scenario: Searching from the results page
    Given I am on the merchant index
    When I search a matching ZIP
    Then I see the merchants matching that ZIP
    And I do not see the merchants not matching that ZIP

  Scenario: Searching for a partial ZIP with results
    Given I am on the home page
    When I search a matching ZIP without the 4-digit extension
    Then I see the merchants matching that partial ZIP

  Scenario: Searching for a ZIP with no results
    Given I am on the home page
    When I search a non-matching ZIP
    Then I see there are no matching merchants

  Scenario: Empty search
    Given I am on the home page
    When I search without a ZIP
    Then I see I must enter a ZIP
