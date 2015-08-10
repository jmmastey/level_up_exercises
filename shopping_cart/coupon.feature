Feature: Coupon
  As a user
  I want to be able to add coupons

  Background:
    Given I view my cart
    And I have products in my cart

  Scenario: Add coupon
    When I add a valid coupon code
    Then I expect to have a discount applied to my cart
    And the add coupon link should be gone

  Scenario: Expired coupon
    When I add an expired coupon
    Then I expect not to have a discount applied to my cart
    And I expect to have an expired coupon error

  Scenario: Invalid coupon
    When I add a non-existant coupon
    Then I expect not to have a discount applied to my cart
    And I expect to have a non-existant coupon error

  Scenario: Add coupon to an empty cart
    When I have no products in my cart
    And I enter in a valid coupon code
    Then I expect not to have a discount applied to my cart
    And I expect to have an empty cart error
