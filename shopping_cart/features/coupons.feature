Feature: Applying coupons

  Scenario: Customer has a valid coupon
    Given the cart has "item_1" with price "$100"
    When the customer applies a valid coupon
    Then the total price should be less than "$100"

  Scenario: Customer has a invalid coupon
    Given the cart has "item_1" with price "$100"
    When the customer applies a invalid coupon
    Then the total price should be equal to "$100"
