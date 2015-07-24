Feature: Manage Coupons
  In order to get better deals
  As a customer
  I want to add coupons to my order

  Background:
    Given I am on the shopping cart page

  @happy
  Scenario: I add a valid unexpired coupon
    When I add a coupon number to the coupon field
    And the coupon is not expired
    Then I should see an updated order cost with the discount included

  @sad
  Scenario: I add a valid expired coupon
    When I add a coupon number to the coupon field
    And the coupon is expired
    Then the order cost should not change
    And I should see a "Coupon Expired" message

  @sad
  Scenario: I add an invalid coupon
    When I add a coupon number to the coupon field
    And the coupon does not associate with any of my items
    Then the order cost should not change
    And I should see an "Invalid Coupon" message