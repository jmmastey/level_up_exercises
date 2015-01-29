Feature: Add coupon for items in cart
  As a customer
  I want to add a coupon to the items in my cart
  To get a discount on my items

  Background:
    Given I am at the shopping cart home page
    And I have a widget in my shopping cart

  Scenario: Enter valid coupon code
    When I submit a valid coupon code
    Then I see that the coupon is valid
    And the widget price is discounted

  Scenario: Enter valid coupon code twice
    When I submit a valid coupon code twice
    Then I see a "coupon already entered" error
    And the discounted price should not change

  Scenario: Enter invalid coupon code
    When I submit an invalid coupon code
    Then I see an "invalid coupon" error
    And the widget price does not change

  Scenario: Enter expired coupon code
    When I submit an expired coupon code
    Then I see an "expired coupon" error
    And the widget price does not change