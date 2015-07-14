#encoding: utf-8

Feature: Sad Coupon Adding
  In order to not get a discount
  As an online shopper
  I should enter invalid coupon codes

  Scenario: Coupon is expired
    Given I'm at the online store
    When I enter a valid coupon code for an item in my cart
    And the coupon has already expired
    Then the price of that item should not change
    And the total of my shopping cart should not update
    And a message should tell me that the coupon is expired

  Scenario: Coupon not valid at this store
    Given I'm at the online store
    When I enter an invalid coupon code 
    Then an error message should display
    And tell me that coupon does not work at this store

  Scenario: Coupon valid for item not in cart
    Given I'm at the online store
    When I enter a valid coupon code
    And the item it discounts is not in my cart
    Then an error message should display
    And tell me that coupon does not apply to anything in my cart
