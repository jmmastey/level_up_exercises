Feature: Estimate shipping costs
  As an online shopper
  I want to see shipping estimates
  Because I want to manage how much I spend

  Background:
    Given I log in
    And I have a cart of 4 items of a product

  Scenario: Begin shipping estimate process
    When I visit the shipping estimate page
    Then I expect to see the shipping address form

  Scenario: Fill in shipping address form
    When I visit the shipping estimate page
    And I fill in my address
    Then I expect to see my estimated order total

  Scenario: Partially fill in shipping address form
    When I visit the shipping estimate page
    And I fill in only my street address
    Then I see an incomplete address error message

  Scenario: Using bogus address
    When I visit the shipping estimate page
    And I fill in a bogus address
    Then I see an invalid address error message
