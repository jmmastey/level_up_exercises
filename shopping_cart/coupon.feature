Feature: Shopping coupons
  As an online shopper
  I want to use coupons
  Because I can save money

Scenario: Using valid coupon
  Given I am viewing the cart
  And the cart total is "100" dollars
  When I apply the coupon code "x3ifwf"
  Then the coupon is marked valid
  And the cart total is "86" dollars

Scenario: Using expired coupon
  Given I am viewing the cart
  And the cart total is "100" dollars
  When I apply the coupon code "goldtier"
  Then the coupon is marked expired
  And the cart total is "100" dollars

Scenario: Using invalid coupon
  Given I am viewing the cart
  And the cart total is "100" dollars
  When I apply the coupon code "boguscoupon"
  Then the coupon is marked invalid
  And the cart total is "100" dollars

Scenario: Leaving coupon field blank
  Given I am viewing the cart
  And the cart total is "100" dollars
  When I type "" for the coupon code
  And I submit the code
  Then the cart total is "100" dollars
