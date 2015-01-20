Feature: Remove item to cart
  As a customer
  I need to able to remove items to cart

  Scenario: Customer removes item to the cart
    Given the cart has "item_1"
    When customer removes the "item_1"
    Then customer should not see "item_1" in the cart
