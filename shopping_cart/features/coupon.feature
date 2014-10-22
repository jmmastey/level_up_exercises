Feature: Product Coupons
  To give consumers special pricing on products
  As a consumer
  I should be able to add valid coupon codes to shopping cart

  Background:
    Given shopping cart is empty
    And "Product 1" costs $5.00
    And "Product 2" costs $20.00
    And "Product 3" cost  $29.99
    And coupon for "5%" off with code "5OFF"
    And coupon for "20%" off with code "DUBOFF"
    And coupon for "99%" off with code "IMACROOK"
    And invalid coupon for "50%" off with code "PARTY1999"
    And I am on the shopping cart page

  Scenario Outline: Using product coupons
    When I add <add_quantity> "<product>" to shopping cart
    And I fill in "Coupon" with <coupon_code>
    And I press "Apply Coupon"
    Then I should see a discount amount $<discount>
    And should see a subtotal of $<sub_total>
    And I should see a <info>

  @happy_path
  Examples:
    | add_quantity | product   | coupon_code | discount | sub_total | info |
    | 1            | Product 1 | 5OFF        | 0.25     | 4.75      |      |
    | 10           | Product 1 | DUBOFF      | 10.00    | 40.00     |      |
    | 100          | Product 1 | IMACROOK    | 495.00   | 5.00      |      |
    | 1            | Product 2 | 5OFF        | 1.00     | 19.00     |      |
    | 10           | Product 2 | DUBOFF      | 40.00    | 160.00    |      |
    | 100          | Product 2 | IMACROOK    | 1980.00  | 20.00     |      |
    | 1            | Product 3 | 5OFF        | 1.50     | 28.49     |      |
    | 10           | Product 3 | DUBOFF      | 59.98    | 239.92    |      |
    | 100          | Product 3 | IMACROOK    | 2969.01  | 29.99     |      |

  @sad_path
  Examples:
    | add_quantity | product   | coupon_code | discount | sub_total | info                                       |
    | 2            | Product 1 | DUBOFF      | 0.00     | 10.00     | Minimum of 10 items to use coupon          |
    | 3            | Product 1 | IMACROOK    | 0.00     | 15.00     | Minimum of 100 items to use coupon         |
    | 2            | Product 2 | DUBOFF      | 0.00     | 40.00     | Minimum of 10 items to use coupon          |
    | 3            | Product 2 | IMACROOK    | 0.00     | 60.00     | Minimum of 100 items to use coupon         |
    | 2            | Product 3 | DUBOFF      | 0.00     | 59.98     | Minimum of 10 items to use coupon          |
    | 3            | Product 3 | IMACROOK    | 0.00     | 89.97     | Minimum of 100 items to use coupon         |
    | 3            | Product 3 | PARTY1999   | 0.00     | 89.97     | Expired coupon. You cannot party like 1999 |

  @bad_path
  Examples:
    | add_quantity | product   | coupon_code | discount | sub_total | info           |
    | 1            | Product 1 | ZEUS        | 0.00     | 5.00      | Invalid Coupon |
    | 1            | Product 2 | ATHENA      | 0.00     | 5.00      | Invalid Coupon |
    | 1            | Product 3 | BOBROSS     | 0.00     | 5.00      | Invalid Coupon |


  @happy_path
  Scenario: Valid coupon for 99% off
    When I add 100 of "Product 1" to shopping cart
    And I fill in "Coupon" with "IMACROOK"
    And I press "Apply Coupon"
    Then I should see 100 of "Product 1" in shopping cart
    And I should see a discount of $495.00
    And I should see a subtotal of $5.00

  @sad_path
  Scenario: Two valid coupons
    When I add 1 of "Product 1" to shopping cart
    And I add 10 of "Product 2" to shopping cart
    And I fill in "Coupon" with "5OFF"
    And I press "Apply Coupon"
    And I fill in "Coupon" with "DUBOFF"
    Then I should see "Can only apply one coupon per order"

  @sad_path
  Scenario: Valid 99% off coupon with only 99 items
    When I add 99 of "Product 1" to shopping cart
    And I fill in "Coupon" with "IMACROOK"
    And I press "Apply Coupon"
    Then I should see "Minimum of 100 items to use coupon"

  @bad_path
  Scenario: Expired coupon from 1999
    When I add 1 of "Product 3" to shopping cart
    And I fill in "Coupon" with "PARTY1999"
    And I press "Apply Coupon"
    Then I should see "Expired coupon. You cannot party like 1999"