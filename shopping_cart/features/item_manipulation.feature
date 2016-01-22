Feature: Shopping cart item manipulation
  In order to track items that I want to purchase
  As an online shopper
  I want the ability to add and remove items to a cart, as well as change quantity.

  Scenario: Ability to add items to cart
    Given an item has an add to cart button
    When a user clicks the add to cart button
    Then the cart should show the item in its contents

  Scenario: Ability to remove an item from cart
    Given the cart has an item in it
    When a user clicks the remove from cart button
    Then the cart should no longer contain the item

  Scenario: Ability to increment in cart item quantity
    Given the cart has an item in it
    When a user increments the item's quantity
    Then the cart should reflect the correct quantity for the item

  Scenario: Ability to decrement in cart item quantity
    Given the cart has an item in it
    When a user decrements the item's quantity
    Then the cart should reflect the correct quantity for the item

  Scenario: Ability to change item quantity to zero and have it removed from cart
    Given the cart has an item in it
    When a user changes the item quantity to 0
    Then the cart should no longer contain the item
