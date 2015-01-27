Feature: shipping estimate

  As a customer
  I want to enter my ZIP code
  So that I can see an estimated shipping cost

  Scenario: enter valid ZIP code
    Given my cart contains items
    When I enter a valid ZIP code
    Then an estimated shipping cost is displayed

  Scenario: enter invalid ZIP code
    Given my cart contains items
    When I enter an invalid ZIP code
    Then an estimated shipping cost is not displayed
    And an error message is displayed
