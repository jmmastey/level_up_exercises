Feature: Add coupons to items in cart
  As a customer
  I should be able to apply coupons to items
  So that I can receive discounts

  Background:
    Given I have "1" "Sample Item A" in my cart
    And the "total" field has value "10.00"

  @happy
  Scenario: I add a coupon to an item in my cart
    When I apply coupon "50PERCENTOFF"
    Then the "total" field has value "5.00"

  @sad
  Scenario: I add a coupon to an item in my cart
    When I apply coupon ""
    Then the "total" field has value "10.00"

  @bad
  Scenario: I add a coupon to an item in my cart
    When I apply coupon "Z"
    Then the "total" field has value "10.00"
    And I should see the message "Please enter a valid coupon"
