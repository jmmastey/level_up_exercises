Feature: Shopping Cart Checkout
  In order to get cart totals
  As a shopper
  I should be able to add coupons and input address

  Background:
    Given I have 2 items in my cart with a total of 20 dollars

  Scenario: Shipping form is filled correctly
    When I enter the address
    Then the cart total is 25 dollars

  Scenario: Shipping form is filled incorrectly
    When I enter the street address
    Then I should see an error message "address not complete"
    And the cart total is still 20 dollars

  Scenario: Shipping form is filled with invalid data
    When I enter an invalid address
    Then should see an error message "address not found"
    And the cart total is still 20 dollars

  Scenario: Add expired coupon to cart
    When I enter an expired coupon
    Then I should see an error message "code expired"
    And the cart total is still 20 dollars

  Scenario: Add valid coupon to a cart
    When I enter a valid coupon
    Then the cart total is 18 dollars
