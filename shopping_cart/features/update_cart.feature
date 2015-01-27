Feature: update shopping cart

  As a customer
  I want to update my cart
  So that I can purchase the right items in the right quantities

  Scenario: remote item from cart
    Given my cart contains an item
    When I remove the item from my cart
    Then the item does not appear in my cart 

  Scenario: update item quantity
    Given my cart contains an item
    When I update the quantity for the item
    Then the item appears in my cart with the new quantity

  Scenario: reduce item quantity to 0
    Given my cart contains an item
    When I update the quantity for the item to 0
    Then the item does not appear in my cart
