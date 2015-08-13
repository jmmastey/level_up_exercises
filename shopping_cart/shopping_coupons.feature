Feature: Shopping coupons
  As an online shopper
  I want to use coupons
  Because I can save money

  Background:
    Given I log in
    And the cart total is "100" dollars of "items"
    And I visit the checkout page

  Scenario: Using valid coupon
    When I apply a valid coupon code
    Then the coupon is marked valid
    And the cart total is "86" dollars of "items"

  Scenario: Using expired coupon
    When I apply an expired coupon code
    Then the coupon is marked expired
    And the expected cart total should still be "100" dollars

  Scenario: Using invalid coupon
    When I apply an invalid coupon code
    Then the coupon is marked invalid
    And the expected cart total should still be "100" dollars

  Scenario: Leaving coupon field blank
    And I submit the code without a coupon
    And the expected cart total should still be "100" dollars
