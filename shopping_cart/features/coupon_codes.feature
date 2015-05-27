Feature: Coupon Codes

Scenario: Apply valid coupon/discount code to Cart
  Given I am an User
    And I am viewing the Cart page
    And I have 1 or more Items in my Cart
  When I enter a valid coupon code
    Then the corresponding amount is subtracted from my subtotal

Scenario: Apply invalid coupon/discount code to Cart
  Given I am an User
    And I am viewing the Cart page
    And I have 1 or more Items in my Cart
  When I enter an invalid coupon code
    Then I see error messaging telling me the coupon code is invalid
