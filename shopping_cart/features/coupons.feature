Feature: coupons

  As a customer
  I want to apply coupons to my cart
  So that I can pay less

  Scenario: apply valid coupon
    Given my cart contains items
    When I apply a valid coupon
    Then the cart subtotal is updated to reflect the coupon amount

  Scenario: apply invalid coupon
    Given my cart contains items
    When I apply an invalid coupon
    Then the cart subtotal is not updated
    And an error message is displayed

  Scenario: apply expired coupon
    Given my cart contains items
    When I apply an expired coupon
    Then the cart subtotal is not updated
    And an error message is displayed
