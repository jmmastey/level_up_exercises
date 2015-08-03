Feature: Using coupons for the cart
  In order to take advantage of product promotions 
  As an online shopper
  I want a place to enter in coupon codes

  Background:
    Given I have 3 items in my cart
    When I click to enter a coupon code

  Scenario: Entering valid coupon code
    And I enter a valid coupon code for the first item
    Then I should see a confirmation message
    And the first item should be discounted from coupon

  Scenario: Entering valid coupon code for an item not in the cart
    And I enter a valid coupon code for an item not in the cart
    Then I should see an "item not in cart" warning message

  Scenario: Entering an expired coupon code
    And I enter an expired coupon code for the first item
    Then I should see an "expired coupon" warning message
    And the first item should not be disouncted from coupon

  Scenario: Entering an invalid coupon code
    And I enter an invalid coupon code
    Then I should see an "invalid coupon" warning message
