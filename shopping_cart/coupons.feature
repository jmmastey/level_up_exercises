Feature: Apply Coupons
  As a customer
  I should be able to apply coupons
  In order to save money

  Background:
    Given We have a valid 10 percent off coupon

  @Happy
  Scenario: I should be able to successfully apply a coupon
    Given I have an item in my cart which has a valid coupon
    When I try to apply the 10 percent coupon code
    Then I should see the price decrease by 10 percent

  @Happy
  Scenario: I should be able to apply the coupon to a mixed collection of items
    Given I have a mixed assortment of items in my cart, some with valid coupons
    When I try to apply the coupon code
    Then I should see the price decrease by the coupon terms

  @Sad
  Scenario: The coupon should not apply to items it doesn't work for
    Given I have 1 item in my cart which has no valid coupon
    When I try to apply the coupon code
    Then The cart price should stay the same

  @Sad
  Scenario: The coupon should give an error when it doesn't apply
    Given I have 1 item in my cart which has no valid coupon
    When I try to apply the coupon code
    Then The cart price should stay the same

  @Sad
  Scenario: Incorrect coupons should not work
    Given I have 1 item in my cart which has a valid coupon
    When I try to apply an invalid coupon code
    Then I should see an error message

  @Sad
  Scenario: Incorrect coupons should not work
    Given I have 1 item in my cart which has a valid coupon
    When I try to apply an invalid coupon code
    Then The cart price should stay the same

  @Sad
  Scenario: Expired coupons should not work
    Given I have 1 item in my cart which has a valid coupon
    When I try to apply an expired coupon code
    Then The cart price should stay the same


  @Sad
  Scenario: Expired coupons should give an error
    Given I have 1 item in my cart which has a valid coupon
    When I try to apply an expired coupon code
    Then I should see an error message


  @Bad
  Scenario: The coupon inputs should be sanitized
    Given I have 1 item in my cart which has a valid coupon
    When I try to apply the coupon code "; DROP TABLE coupons"
    Then I should see an error message





