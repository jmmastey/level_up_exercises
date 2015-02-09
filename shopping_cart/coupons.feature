Feature: add coupons
  Background:
    Given I am at the cart page
    And the cart quantity is 1

  Scenario: valid coupon
    When I add a valid coupon
    Then I see the item price is discounted

  Scenario: coupon with conditions
    When I add a valid coupon
    And the coupon has conditions that are not met
    Then I see "Error: Coupon Conditions Not Met"
    And the item price is not discounted

  Scenario: invalid coupon
    When I add an invalid coupon
    Then I see "Error: Coupon Invalid"
    And the item price is not discounted

  Scenario: expired coupon
    When I add an expired coupon
    Then I see "Error: Coupon Expired"
    And the item price is not discounted

  Scenario: multiple coupons
    Given I add a valid coupon
    When I add another coupon
    Then I see "Error: Only One Coupon May Be Used Per Order"
    And the item price is not discounted again

  Scenario: offers when logged in
    When I login
    And I am eligible for coupons
    Then I see "Alert: You Are Eligible For Offers"
