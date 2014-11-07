Feature: Cart line items page
  As a shopper
  I want an itemized cart content page
  So can view and modify my order and begin checkout

# Happy paths: :^D

Scenario: Locate cart item page from landing page
  Given I am on a landing page
  When I click the shopping cart button
  Then I see the cart item page
 
Scenario: Locate cart item page from item page
  Given I am on an item page
  When I click the shopping cart button 
  Then I see the cart item page

Scenario: Cart item page with empty cart
  Given I have no items in my cart
  When I visit the cart item page
  Then I see a message "No items in cart"
  
Scenario: Normal line item contents
  Given I have 1 available item in my cart
  And the item has price $5
  When I visit the cart item page
  Then I see a line item for 1 item
  And the line item shows item name
  And the line item shows item unit price $5
  And the line item shows quantity 1 of item
  And the line item shows item net price $5
  And the line item shows item description
  And the line item shows item stock number
  And the line item show a link to item page

Scenario: Line item for multiples of same item
  Given I have 3 of an available item in my cart
  And the item has price $2
  When I visit the cart item page
  Then I see a line item for 1 item
  And the line item shows item unit price $2
  And the line item shows quantity 3 of item
  And the line item shows item net price $6

Scenario: Line items for each normal item
  Given I have 5 different items in my cart
  When I visit the cart item page
  Then I see 5 line items for 5 items

Scenario: Coupon line item
  Given I have an order-level $5-off coupon in my cart
  When I visit the cart item page
  Then I see a line item for the coupon
  And the line item shows the coupon code
  And the line item shows the coupon promotion name
  And the line item shows item net price -$5

Scenario: Line items for each coupon in effect
  Given I have 2 items in my cart
  And I have 2 item-level coupons for $2 each in my cart
  When I visit the cart item page
  Then I see 2 coupon line items
  And each line item has item price -$2

Scenario: Sales Tax line item
  Given I have an order with item subtotal $10
  When the order has sales tax rate 5%
  Then the cart shows a tax line item
  And the line item has item price $0.05

Scenario: Item subtotal
  Given I have an order with item subtotal $20
  When I view the cart item page
  I see an item subtotal $20

Scenario: Item subtotal with coupons
  Given I have an order with item subtotal $20 excluding coupons
  And I have an unconditional order-level $5-off coupon in my cart
  When I view the cart item page
  I see an item subtotal $15

Scenario: Total order price
  Given I have an order with item subtotal $20
  And I have shipping cost $5
  And I have 5% tax rate
  And I have $2 shipping
  When I view the cart item page
  I see an order total price $23

Scenario: Checkout button
  Given I have an order with item subtotal $5
  And I am viewing the cart item page
  When I press the checkout button
  I see the order payment page:w

# Sad paths: ;-(

Scenario: Line items for out-of-stock item
  Given I have 1 out-of-stock item in my cart
  When I visit the cart item page
  Then I see 1 line item for 1 item
  And the line item shows an out-of-stock warning
  And the line item shows an expected delivery date

Scenario: Out-of-stock line item prices
  Given I have 1 available item priced $10 in my cart
  When I add 1 out-of-stock item priced $10
  Then I see 2 line items for 2 items
  And I see item subtotal $20

Scenario: Price change for item already in cart
  Given I have 1 available item priced $20 in my cart
  And the item price changes to $25
  When I visit the cart item page
  Then the line item shows a price-change warning
  And the line item price is $25

Scenario: Item in cart is discontinue prior to purchase
  Given I have 1 available item priced $3 in my cart
  And the item is discontinued and no longer available
  When I visit the cart item page
  Then the line item shows a discontinued-item warning
  And the line item price is $0

# Bad: >:^(
