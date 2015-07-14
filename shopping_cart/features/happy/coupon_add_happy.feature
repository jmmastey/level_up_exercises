#encoding: utf-8

Feature: Happy Coupon Adding
  In order to get a discount
  As an online shopper
  I should enter a valid coupon
  And it should apply to an item in my cart

  Scenario: Coupon is valid for one item
    Given I'm at the online store
    When I enter a coupon code valid for a single item in my cart
    Then the price of that item should change
    And the price of no other item of its type should change
    And the total of my shopping cart should update

  Scenario: Coupon is valid for multiple items
    Given I'm at the online store
    When I enter a valid coupon code for a type of item in my cart
    Then the price of all of those items should change
    And the total of my shopping cart should update
