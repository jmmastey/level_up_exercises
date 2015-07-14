#encoding: utf-8

Feature: Happy Coupon Adding
  In order to get a discount
  As an online shopper
  I should enter a valid coupon
  And it should apply to an item in my cart

  Scenario: Coupon is valid for one item (in cart == 1)
    Given I'm at the online store
    When I enter a valid coupon code for an item in my cart
    Then the price of that item should change
    And the total of my shopping cart should update

  Scenario: Coupon is valid for one item (in cart > 1)
    Given I'm at the online store
    When I enter a valid coupon code for an item in my cart
    Then the price of only one of those items should change
    And the total of my shopping cart should update

  Scenario: Coupon is valid for multiple items
    Given I'm at the online store
    When I enter a valid coupon code for a type of item in my cart
    Then the price of all of those items should change
    And the total of my shopping cart should update
