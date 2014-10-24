Feature: Shopping Cart
  A simple shopping cart that allows people to add a item to a cart
  and then on those items be able to add, remove or change quantities.

  The shopping cart should provide shipping estimates on items without
  forcing the user to checkout. Additionally, the user should be allowed
  to add unexpired coupons and have the new price reflected for the item
  once the coupons have been applied.

  The user's cart can have 2 states: a cart with items when the user is not
  logged in, and a cart from a previous session.

  Background:
    Given I have a empty shopping cart
    And "Item 1" which costs $10.00
    And "Item 2" which costs $20.00
    And "Item 3" which costs $30.00
    
  Scenario Outline: Add a product to the shopping cart
    When I add <quantity> of "<item>" to shopping cart
    Then I should see <subtotal> of products in shopping cart
    And I should see <product_qty> of "<item>" in shopping cart

  @happy_path
  Examples:
    | quantity | item   | subtotal | product_qty |
    | 1        | Item 1 | 10.00    | 1           |
    | 5        | Item 1 | 50.00    | 5           |
    | 1        | Item 2 | 20.00    | 1           |


  @sad_path
  Examples:
    | quantity | item   | subtotal | product_qty |
    | 0        | Item 1 | 10.00    | 1           |
    | 0        | Item 1 | 50.00    | 5           |

  @bad_path
  Examples:
    | quantity | item   | subtotal | product_qty |
    | 0        | Item 1 | 10.00    | 1           |
    | 0        | Item 1 | 50.00    | 5           |