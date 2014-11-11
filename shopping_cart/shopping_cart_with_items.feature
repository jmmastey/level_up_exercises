Feature: Shopping cart with items
  As a shopper
  I want a representation of my cart
  So I can view and modify my order and begin checkout

# SO HAPPY

Scenario: Locate cart item page from landing page
  Given I am on a landing page
  When I click the shopping cart button
  Then I see the shopping cart page
 
Scenario: Locate cart item page from item page
  Given I am on an item page
  When I click the shopping cart button 
  Then I see the shopping cart page

Scenario: Cart item page with empty cart
  Given I have no items in my cart
  When I visit the cart item page
  Then I see "No items in cart" message
  
Scenario: Normal line contents
  Given I have 1 available item in my cart
  And the item has price $5
  When I visit the cart item page
  Then I see a line for 1 item
  And the line shows item name
  And the line shows item unit price $5
  And the line shows quantity 1 of item
  And the line shows item net price $5
  And the line shows item description
  And the line shows item stock number
  And the line show a link to item page

Scenario: Line for multiples of same item
  Given I have 5 of an available item in my cart
  And the item has price $5
  When I visit the cart item page
  Then I see a line for 1 item
  And the line shows item unit price $5
  And the line shows quantity 5 of item
  And the line shows item net price $25

Scenario: Line for each normal item
  Given I have 5 different items in my cart
  When I visit the shopping cart page
  Then I see 5 lines for 5 items

Scenario: Coupon line
  Given I have an order-level $5-off coupon in my cart
  When I visit the cart item page
  Then I see a line for the coupon
  And the line shows the coupon code
  And the line shows the coupon promotion name
  And the line shows item net price -$5

Scenario: Line for each coupon in effect
  Given I have 2 items in my cart
  And I have 2 item-level coupons for $2 each in my cart
  When I visit the cart item page
  Then I see 2 coupon lines
  And each line has item price -$2

Scenario: Sales Tax line
  Given I have an order with item subtotal $10
  When the order has sales tax rate 5%
  Then the cart shows a tax line
  And the line has item price $0.05

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
  I see the order total price $23

Scenario: Checkout button
  Given I have an order with item subtotal $5
  And I am viewing the cart item page
  When I press the checkout button
  I see the payment page

# SO SAD

Scenario: Lines for out-of-stock item
  Given I have 1 out-of-stock item in my cart
  When I visit the cart item page
  Then I see 1 line for 1 item
  And the line shows an out-of-stock warning

Scenario: Out-of-stock line prices
  Given I have 1 available item priced $10 in my cart
  When I add 1 out-of-stock item priced $10
  Then I see 2 lines for 2 items
  And I see item subtotal $20

Scenario: Price change for item already in cart
  Given I have 1 available item priced $20 in my cart
  And the item price changes to $25
  When I visit the cart item page
  Then the line shows a price-change warning
  And the price line is $25

Scenario: Item in cart is discontinued prior to purchase
  Given I have 1 available item priced $3 in my cart
  And the item is discontinued and no longer available
  When I visit the cart item page
  Then the item line shows a discontinued-item warning
  And the price line is $0

# SO BAD