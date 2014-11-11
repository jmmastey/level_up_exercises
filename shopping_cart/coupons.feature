Feature: User submits coupon code
  As a shopper
  I want to apply coupons to my order

# SO HAPPY

Scenario: Total-value coupon code
  Given I have an order with item subtotal $100 in my cart
  When I apply a $20-off unconditional order-value coupon code
  Then my cart shows a coupon item for -$20
  And my cart item subtotal is $80

Scenario: Total-value percent-off coupon code
  Given I have an order with item subtotal $100 in my cart
  When I apply a 25% total price coupon code
  Then my cart shows a coupon item for -25% of total
  And my cart item subtotal is $75

Scenario: Total-value Coupon code for value greater than order total cost
  Given I have an order with item subtotal $5 in my cart
  When I apply a $10-off unconditional order-value coupon code
  Then my cart shows a coupon item for -$5
  And my cart item subtotal is $0

Scenario: Item-value coupon code for value greater than item
  Given I have an order with item subtotal $10 in my cart
  And I have one item priced $3 in my cart
  And I have a coupon code for $5 off the item
  When I apply the coupon code
  Then my cart shows a coupon item for -$3
  And my cart item subtotal is $7

Scenario: Free shipping coupon code
  Given I have an order with shipping cost of $3.99 in my cart
  When I apply a free-shipping coupon code
  Then my cart shows shipping as $0
 
Scenario: Item-value coupon code
  Given I have two items in my cart
  And each item has base price $10
  And I have a $5-off item-value coupon code that applies to one of the items
  When I apply the coupon code to my cart
  Then my cart shows a coupon item for -$5
  And my cart item subtotal is $15

Scenario: Item-value percent-off coupon code
  Given I have two items in my cart
  And each item has base price $10
  And I have a 25%-off item-value coupon code that applies to one of the items
  When I apply the coupon code to my cart
  Then my cart shows a coupon item for -$2.5
  And my cart shows item subtotal $17.5

Scenario: Minimum-limit requirement coupon code
  Given I have an order with item subtotal $50
  And I have a $5-off coupon with minumum limit requirement $40
  When I apply the coupon code to my cart
  Then my cart shows a coupon item for -$5
  And my cart shows item subtotal $45

# SO SAD

Scenario: Expired coupon code
  Given I have an order with item subtotal $30 in my cart
  When I apply an expired $10-off unconditional order-value coupon code
  Then I see an expired coupon warning
  And my cart does not show a coupon item for -$10
  And my cart shows item subtotal is $30

Scenario: Unrecognized coupon code
  Given I have an order with item subtotal $30 in my cart
  When I apply an unrecognized coupon code
  Then I see an unrecognized coupon warning
  And my cart does not show a coupon item
  And my cart shows item subtotal is $30

Scenario: Invalid coupon code
  Given I have an order with item subtotal $10 in my cart
  When I apply an ill-formatted coupon code
  Then my cart does not show a coupon item
  And my cart item subtotal is $10

Scenario: Item-value coupon with no applicable item in cart
  Given I have an order with item subtotal $15 in my cart
  And I have an 10%-off item-value coupon for an item not in my cart
  When I apply the coupon code
  Then I see a no-such-item dialog
  And my cart shows a coupon item for $0
  And my cart item subtotal is $15

Scenario: Minimum-limit coupon code with unmet limit requirement
  Given I have an order with item subtotal $10 in my cart
  And I have a $10-off coupon with minimum limit requirement $100
  When I apply the coupon code
  Then I see a minimum-limit reminder
  And my cart shows a coupon item for $0
  And my cart item subtotal is $10

Scenario: Mutually-exclusive coupon codes
  Given I have an order with item subtotal $95 in my cart
  And I have an exclusive order-value coupon code for 5%-off in my cart
  When I apply an exclusive order-value coupon code for $5-off
  Then I see a coupon-restriction dialog
  And my cart does not show a new coupon item
  And my cart item subtotal is $95

Scenario: Submit duplicate coupon codes
  Given I have an order with item subtotal $25 in my cart
  And I have a coupon with code "CouponTest" in my cart
  When I apply a coupon code "CouponTest"
  Then I see a duplicate-coupon warning
  And my cart does not show a new coupon item
  And my cart item subtotal is $25

# SO BAD