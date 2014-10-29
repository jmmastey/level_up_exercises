Feature: Apply Coupons
  Customer should be able to enter a coupon code and get a updated price for
  all items in a shopping cart

  Background:
    Given I have a empty shopping cart
    And "Item 1" which costs $10.00
    And "Item 2" which costs $20.00
    And "Item 3" which costs $50.00
    And "Item 4" which costs $100.00
    And a coupon for "10%" off with code "BACON"
    And a coupon for "30%" off with code "KITTENS"
    And a coupon for "90%" off with code "JOE"
    And a invalid coupon for "99%" off with code "IAMCHEAP"
    And I am on the shopping cart page

  Scenario Outline: Attempt to use product coupons
    When I add <quantity> of "<item>" to shopping cart
    When I set "Coupon" with "<coupon_code>"
    And I press "Add Coupon"
    Then I should see total discount of "<total_discount>"
    And I should see items subtotal of $<subtotal> in the shopping cart
    And I should see message "<info>"

  @happy_path
  Examples: Add a valid coupon code for products
    | quantity | item   | coupon_code | total_discount | subtotal | info |
    | 1        | Item 1 | BACON       | $1.00          | 9.00     |      |
    | 1        | Item 2 | KITTENS     | $6.00          | 14.00    |      |
    | 1        | Item 1 | JOE         | $9.00          | 1.00     |      |
    | 2        | Item 3 | BACON       | $10.00         | 90.00    |      |
    | 3        | Item 3 | JOE         | $45.00         | 5.00     |      |

  @sad_path
  Examples: Use coupons that have restrictions on use or are valid, yet expired
    | quantity | item   | coupon_code | total_discount | subtotal | info                                               |
    | 1000     | Item 1 | BACON       | $0.00          | 10000.00 | Coupon only valid for up to 10 items               |
    | 1        | Item 4 | BACON       | $0.00          | 10000.00 | Must buy more than one of this item for use coupon |
    | 1        | Item 1 | IAMCHEAP    | $0.00          | 10.00    | Coupon has expired.                                |

  @bad_path
  Examples: Use invalid coupon codes
    | quantity | item   | coupon_code | total_discount | subtotal  | info           |
    | 1        | Item 1 | MEOWMEOW    | $0.00          | $10.00    | Invalid Coupon |
    | 1000     | Item 4 | EWGROSS     | $0.00          | $10000.00 | Invalid Coupon |
