Feature: Remove Products from Shopping Cart
  As a customer
  I want to remove products from my shopping cart
  In order to not purchase them

  Background:
    Given I have added a product to my cart

  Scenario: Remove Product From Cart (Good Path)
    Given I am logged in
    And I am on the Shopping Cart page
    When I click "Remove Product"
    Then I should have 0 products in my cart

  Scenario: Not logged in (Bad Path)
    Given I am not logged in
    And I am on the Shopping Cart page
    When I click "Remove Product"
    Then I should see "Please log in to update your cart."
