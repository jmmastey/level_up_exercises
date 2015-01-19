Feature: Add item to cart
  As a customer
  I need to able to add items to cart

  Scenario: I add item to the cart
    Given the cart is empty
    When "item_1" is added to cart
    Then I should see "item_1" in the cart