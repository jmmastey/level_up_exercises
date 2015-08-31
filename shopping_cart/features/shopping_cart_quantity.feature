Feature: Shopping Cart Checkout
  In order to manage cart items
  As a shopper
  I should be able to delete and add items

  Scenario Outline: Changing cart quantities
    Given there exists "user" with 2 items in the cart
    And I see the cart
    Then I want to <change> <quantities> item

    Examples:
    | change   | quantities |
    | add      | 2          |
    | subtract | 1          |
    | delete   | 0          |
