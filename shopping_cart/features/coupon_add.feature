#encoding: utf-8

Feature: Bad Coupon Adding
  In order to not get a discount
  As an online shopper
  I should enter an expired coupon

  @happy
  Scenario: Coupon expires after entry and before checkout
    Given I'm at the online store
    And I have entered a valid coupon
    When the coupon expires
    And I click checkout
    Then the coupon should be un-applied

  @happy
  Scenario: Coupon is valid for one item
    Given I'm at the online store
    When I enter a coupon code valid for a single item in my cart
    Then the price of that item should change
    And the price of no other item of its type should change
    And the total of my shopping cart should update

  @happy
  Scenario: Coupon is valid for multiple items
    Given I'm at the online store
    When I enter a valid coupon code for a type of item in my cart
    Then the price of all of those items should change
    And the total of my shopping cart should update

  @sad
  Scenario: Coupon is expired
    Given I'm at the online store
    When I enter a valid coupon code for an item in my cart
    And the coupon has already expired
    Then the price of that item should not change
    And the total of my shopping cart should not update
    And a message should tell me that the coupon is expired

  @bad
  Scenario: Coupon not valid at this store
    Given I'm at the online store
    When I enter an invalid coupon code 
    Then an invalid coupon error message should display
    And tell me that coupon does not work at this store

  @bad
  Scenario: Coupon valid for item not in cart
    Given I'm at the online store
    When I enter a valid coupon code
    And the item it discounts is not in my cart
    Then a missing item error message should display
    And tell me that coupon does not apply to anything in my cart
