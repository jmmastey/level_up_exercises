* I should be able to add coupons, which are hopefully not expired.

Feature: Add coupons to items in cart
  As a customer
  I should be able to apply coupons to items
  So that I can receive discounts

  Scenario: I add a coupon to an item in my cart
    Given I have "1" "Sample Item A" in my cart
    And the "total" field has value "10.00"
    When I apply coupon "50PERCENTOFF"
    Then the "total" field has value "5.00"
