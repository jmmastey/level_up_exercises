Feature: applying coupons
  In order to use coupons
  A user adds them to their cart


   Scenario: the customer adds a coupon
     Given a user that is logged in
     When they add a product to their cart
     And add an applicable, valid coupon
     Then the value of the coupon is deducted from their cart's total

  Scenario: the customer adds an inapplicable coupon
    Given a user that is logged in
    When they add a product to their cart
    And add an inapplicable coupon
    Then an error message stating that the coupon is inapplicable is shown

  Scenario: the customer adds an expired coupon
    Given a user that is logged in
    When they add a product to their cart
    And add an expired coupon
    Then an error message stating that the coupon is expired is shown
