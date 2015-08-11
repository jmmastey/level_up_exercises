Feature: Shopping Cart Checkout
  In order to get total price updates
  As a shopper
  I should be able to add coupons and input address

  Background:
    Given I viewing "checkout"

  Scenario Outline: Enter address information
    And I enter the <address>
    Then I should get shipping <ship_cost>
    And I should get total <cost>

    Examples:
    | address | ship_cost | cost |
    | 60614   | 30        | 31   |
    | 60615   | 31        | 32   |

  Scenario Outline: Add expired coupon
    And I enter a "coupon"
    Then the status is "expired"

  Scenario Outline: Add valid coupon
    And I enter a "coupon"
    And the coupon is for <discount> off <item>
    And the item is currently <item_cost>
    Then I update the cost
    And item is now <item_cost>
    And I should get total <cost>

    Examples:
    | discount | item | item_cost  | item_cost | cost |
    | 20       | soap | 10         |      8    |  16  |
    | 50       | hat  | 10         |      5    |  10  |
