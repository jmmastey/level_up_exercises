Feature: User submits coupon code
  As a thrifty shopper
  I want to apply coupons to my order
  So I can pay less money

# Happy paths :^D

Scenario: Dollar-value coupon code
  Given I have an order with item subtotal $30 in my cart
  When I apply a $10-off unconditional order-level coupon code
  Then my cart shows a coupon item for -$10
  And my cart item subtotal is $20

Scenario: Order-level Coupon code for value greater than order cost
  Given I have an order with item subtotal $5 in my cart
  When I apply a $10-off unconditional order-level coupon code
  Then my cart shows a coupon item for -$5
  And my cart item subtotal is $0

Scenario: Item-level coupon code for value greater than item
  Given I have an order with item subtotal $10 in my cart
  And I have one item priced $3 in my cart
  And I have a coupon code for $5 off the item
  When I apply the coupon code
  Then my cart shows a coupon item for -$3
  And my cart item subtotal is $7

Scenario: Percent-off coupon code
  Given I have an order with item subtotal $100 in my cart
  When I apply a 10%-off unconditional order-level coupon code
  Then my cart shows a coupon item for -$10
  And my cart item subtotal is $90

Scenario: Free shipping coupon code
  Given I have an order with shipping cost $15 in my cart
  When I apply a free-shipping coupon code
  Then my cart shows shipping subtotal $0
 
Scenario: Item-level dollar-value coupon code
  Given I have two items in my cart
  And each item has base price $10
  And I have a $5-off item-level coupon code that applies to one of the items
  When I apply the coupon code to my cart
  Then my cart shows a coupon item for -$5
  And my cart item subtotal is $15

Scenario: Item-level Percent-off coupon code
  Given I have two items in my cart
  And each item has base price $10
  And I have a 20%-off item-level coupon code that applies to one of the items
  When I apply the coupon code to my cart
  Then my cart shows a coupon item for -$2
  And my cart shows item subtotal $18

Scenario: Minimum purchase requirement coupon code
  Given I have an order with item subtotal $50
  And I have a $5-off coupon with minumum purchase requirement $40
  When I apply the coupon code to my cart
  Then my cart shows a coupon item for -$5
  And my cart shows item subtotal $45

# Sad paths: ;^(

Scenario: Expired coupon code
  Given I have an order with item subtotal $30 in my cart
  When I apply an expired $10-off unconditional order-level coupon code
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

Scenario: Item-level coupon with no applicable item in cart
  Given I have an order with item subtotal $15 in my cart
  And I have an 10%-off item-level coupon for an item not in my cart
  When I apply the coupon code
  Then I see a no-such-item dialog
  And my cart shows a coupon item for $0
  And my cart item subtotal is $15

Scenario: Minimum-purchase coupon code with unmet purchase requirement
  Given I have an order with item subtotal $10 in my cart
  And I have a $10-off coupon with minimum purchase requirement $100
  When I apply the coupon code
  Then I see a minimum-purchase reminder
  And my cart shows a coupon item for $0
  And my cart item subtotal is $10

Scenario: Mutually-exclusive coupon codes
  Given I have an order with item subtotal $95 in my cart
  And I have an exclusive order-level coupon code for 5%-off in my cart
  When I apply an exclusive order-level coupon code for $5-off
  Then I see a coupon-restriction dialog
  And my cart does not show a new coupon item
  And my cart item subtotal is $95

Scenario: Submit duplicate coupon codes
  Given I have an order with item subtotal $25 in my cart
  And I have a coupon with code "TEST123" in my cart
  When I apply a coupon code "TEST123"
  Then I see a duplicate-coupon warning
  And my cart does not show a new coupon item
  And my cart item subtotal is $25

# Bad paths: >:^(

Scenario: User submits junk form values
  Given I have an order with item subtotal $50 in my cart
  When I submit a modified form with illegal coupon code characters
  Then I see a general-error page 
  And a link returning to the cart item page
