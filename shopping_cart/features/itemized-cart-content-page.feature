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
  And the line item has item prce $0.05

Scenario: Destination address for calculating shipping
  Given I am viewing the cart item page
  ..?

Scenario: Shipping line item
  

Scenario: Item subtotal

Scenario: Item subtotal with coupons

Scenario: Total order price

Scenario: Checkout button


# Sad paths: ;-(

Scenario: Line items for out-of-stock item
  Given I have 1 out-of-stock item in my cart
  When I visit the cart item page
  Then I see 1 line item for 1 item
  And the line item shows an out-of-stock warning
  And the line item shows an expected delivery date

Happy
  Line for available item with same price appears normally showing name, price, and quantity and
  contributes to cart total
Sad:
  Line for item gone out-of-stock is anunciated with "out of stock" warning and
  contributes to cart total
  Line item for item with changed proce is anunciated with "price change"
  warning
  Line for discontinued items is anunciated with "discontinued" warning and does
  not contribute to cart total
Bad:

