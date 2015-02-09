Feature: get shipping estimates
  Background:
    Given I am at the cart page
    And the cart quantity is 1
    And I am not logged in

  Scenario: with location services
    Given I enable location services
    And I click "estimate shipping"
    Then I should see "Shipping estimate"

  Scenario: with zip code
    Given I fill in "zip code" with "60604"
    And I click "estimate shipping"
    Then I should see "Shipping estimate"

  Scenario: with invalid zip code
    Given I fill in "zip code" with "abcde"
    And I click "estimate shipping"
    Then I should see "Error: Invalid Zip Code"

  Scenario: with zip code not served
    Given I fill in "zip code" with "99652"
    And I click "estimate shipping"
    Then I should see "Error: Zip Code Not Served"

  Scenario: with city, state
    Given I fill in "city" with "Chicago"
    And I fill in "state" with "IL"
    Then I should see "Shipping estimate"

  Scenario: with invalid City and State
    Given I fill in "city" with "Wonkaville"
    And I fill in "state" with "Wonkaland"
    And I click "estimate shipping"
    Then I should see "Error: Invalid City State Combination"

  Scenario: with invalid City
    Given I fill in "city" with "Wonkaville"
    And I fill in "state" with "IL"
    And I click "estimate shipping"
    Then I should see "Error: Invalid City State Combination"

  Scenario: with invalid State
    Given I fill in "city" with "Chicago"
    And I fill in "state" with "Illinoize"
    And I click "estimate shipping"
    Then I should see "Error: Invalid City State Combination"

  Scenario: location with login
    Given I login
    And I have a location within account details
    And I click "estimate shipping"
    Then I should see "Shipping estimate"
    