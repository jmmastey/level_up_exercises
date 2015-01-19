Feature: Applying coupons

  Scenario: Customer has a valid coupon
    Given the cart has "item_1" and "item_2"
    When the customer applies a valid coupon
    Then the total price should be less than actual price

  Scenario: Customer has a invalid coupon
    Given the cart has "item_1" and "item_2"
    When the customer applies a valid coupon
    Then the total price should be equal to actual price