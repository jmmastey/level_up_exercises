#encoding: utf-8

Feature: Sad Coupon Adding
  In order to get a discount
  As an online shopper
  I should enter a valid coupon
  And it should apply to an item in my cart

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

  Scenario: Multiple coupons entered for one item
    Given I'm at the online store
    When I enter a valid coupon code for an item
    And I enter another valid coupon code for that same item
    Only the first coupon should apply
    And the second one should not be applied to the item

  Scenario: Using a coupon code across multiple purchases
    Given I'm at the online store
    When I enter a valid coupon code for an item
    And complete my purchase of that item
    Then I should be unable to use that coupon again
