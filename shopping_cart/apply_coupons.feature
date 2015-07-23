Ability: Coupons Applied to Cart Purchases

  As a customer
  I need the ability to apply coupons to my cart purchases
  So that I can get good deals

  Background:
    Given an authenticated customer

  Scenario: Applying coupon with value-based discount
    Given a cart with products where the total cost is $20.00
    When a coupon for $10.00 is applied to the order
    Then the total cost will be $10.00

  Scenario: Applying coupon with percent-based discount
    Given a cart with products where the total cost is $20.00
    When a coupon for 15% off is applied to the order
    Then the total cost will be $18.00

  Scenario: Applying coupon for greater than total cost
    Given a cart with products where the total cost is $20.00
    When a coupon for $30.00 is applied to the order
    Then the coupon value is now $10.00
    And the total cost is will be $0.00

  Scenario: Applying standard coupons does not reduce shipping costs
    Given a cart with products where the subtotal is $10.00
    And the shipping cost is $3.00
    When a coupon for $10.00 is applied to the order
    Then the total cost will be $3.00

  Scenario: Applying shipping cost coupons
    Given a cart with products where the subtotal is $10.00
    And the shipping cost is $3.00
    When a shipping cost coupon for $3.00 is applied to the order
    Then the total cost will be $10.00

  Scenario: Applying expired coupons
    Given a cart with products
    When an expired coupon code is applied to the order
    Then an expired coupon warning is displayed
    And the total purchase price remains unchanged

  Scenario: Applying unrecognized coupons
    Given a cart with products
    When a coupon with a valid but unrecognized code is applied to the order
    Then an unrecognized coupon warning is displayed
    And the total purchase price remains unchanged

  Scenario: Applying already-used coupons
    Given a cart with products
    And a coupon that has already been applied to a previous order
    When the coupon is applied to the current order
    Then an already used coupon message is displayed
    And the total purchase price remains unchanged

  Scenario: Applying invalid coupon codes
    Given a cart with products
    When an invalid coupon code is applied to the order
    Then an invalid coupon code warning is displayed
    And the total purchase price remains unchanged

  Scenario: Applying coupons to a no-cost order
    Given a cart with products where the total cost is $0.00
    When a coupon is applied to the order
    Then a coupon unable to be applied message is displayed

  Scenario: Applying a coupon more than once to the same order
    Given a cart with products and a coupon applied to the purchase
    When that same coupon is applied again
    Then a coupon already applied to order message is displayed

  Scenario: Applying a coupon with no applicable products
    Given a cart with products that are not subject to coupons
    When a coupon is applied to the cart
    Then a coupon cannot be applied message is displayed

  Scenario: Applying a minimum-limit coupon with insufficient limits
    Given a cart with products where the total cost is $100.00
    And a coupon that applies only for orders of $150.00 or more
    When that coupon is applied to the order
    Then cannot apply coupon due to minimum limit message is displayed

  Scenario: Applying coupons that are mutually-exclusive
    Given a cart with products that are marked as downloadable
    When a coupon that applies only to non-online content is applied
    Then a coupon content restriction message is displayed
