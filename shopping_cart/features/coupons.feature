Feature: Buyer uses Coupons

Given I am on the checkout page
  And I have an item in my cart
  And the total is $10.00
  When I enter a 10% discount coupon code
  And the coupon expiration is equal or greater than today
  Then I should see 'Discount Applied'
  And The 'Cart Total' decreased by $1.00

Given I am on the checkout page
  And I have an item in my cart
  When I enter a 10% discount coupon code
  And the coupon expiration is in the past
  Then I should see 'Coupon not valid'

Given I am on the checkout page
  And I have an item in my cart
  And The product cost is $5.00
  When I enter a product coupon code for $1
  And the coupon expiration is equal or greater than today
  Then I should see the item cost decreased by $1

Given I am on the checkout page
  And I have an item in my cart
  And The product cost is $5.00
  When I enter a product coupon code for $10.00
  And the coupon expiration is equal or greater than today
  Then I should see the item cost decreased by $5.00