Feature: Ability to apply coupons to cart
  In order to get discounts on items
  As an online shopper
  I want the ability to add a valid coupon code

  Scenario: Ability to apply valid coupons to items in cart
    Given the cart contains one or more items
    When a user enters a valid coupon code
    Then the cart should show a discounted total price of items

  Scenario: Bad coupon codes display an invalid coupon message
    Given the cart contains one or more items
    When a user enters an invalid coupon code
    Then the cart should display an invalid coupon message