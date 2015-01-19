Feature: Remove item to cart
  As a customer
  I need to able to remove items to cart

  Scenario: I remove item to the cart
    Given the cart has "item_1"
    When I remove the "item_1"
    Then I should not see "item_1" in the cart
