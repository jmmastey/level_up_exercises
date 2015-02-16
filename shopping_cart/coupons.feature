Feature: Coupons

  Background:
    Given I am at the checkout page
    And the cart is not empty

  Scenario: valid coupon code
    Given I enter a valid coupon code
    Then I see the new discounted price

  Scenario: invalid coupon code
    Given I enter an invalid coupon code
    Then I see 'Error: Invalid Coupon'

  Scenario: expired coupon code
    Given I enter an expired coupon code
    Then I see 'Error: Coupon is Expired'

  Scenario: conditions not met
    Given I enter a valid copuon code
    And the conditions of the code are not met
    Then I see 'Error: Coupoon Conditions are Not Met'

  Scenario: multiple coupons
    Given I enter a valid coupon code
    And I enter another valid coupon code
    Then I see 'Sorry, only one coupon per order'
    And I see the discounted price