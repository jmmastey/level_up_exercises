Feature: add to cart

  As a customer
  I want to add items to my cart
  So that I may purchase them later

  Scenario: add item to empty cart
    Given my cart is empty
    When I add an item to my cart
    Then the item appears in my cart

  Scenario: add item to cart containing items
    Given my cart contains items
    When I add an item to my cart
    Then the item appears in my cart
    And the original items appear in my cart

  Scenario: add item to cart containing same item
    Given my cart contains an item
    When I add the same item again
    Then the item appears in my cart with a quantity of 2
