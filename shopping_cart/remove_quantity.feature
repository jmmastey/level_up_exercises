Feature: Remove Products from Shopping Cart
  As a customer
  I want to remove products from my shopping cart
  In order to not purchase them

  Background:
    Given I have added a "hammer" to my cart

  Scenario: Remove Product From Cart (Good Path)
    Given I am logged in
    And I am on the Shopping Cart page
    And the total cost is $10.00
    When I remove the "hammer" from my cart
    Then I should have 0 hammers in my cart
    And the total cost is $0.00

  Scenario: Remove Product From Cart with Multiple Products (Good Path)
    Given I am logged in
    And I have added a "screwdriver" to my cart
    And I am on the Shopping Cart page
    And the total cost is $15.00
    When I remove the "hammer" from my cart
    Then I should have 0 hammers in my cart
    And I should have 1 screwdriver in my cart
    And the total cost is $5.00

  Scenario: Not logged in (Bad Path)
    Given I am logged out
    And I am on the Shopping Cart page
    When I remove the "hammer" from my cart
    Then I should see "Please log in to update your cart."
