#encoding: utf-8

Feature: Bad Coupon Adding
  In order to not get a discount
  As an online shopper
  I should enter an expired coupon

  Scenario: Coupon expires after entry and before checkout
    Given I'm at the online store
    And I have entered a valid coupon
    When the coupon expires
    And I click checkout
    Then the coupon should be un-applied
