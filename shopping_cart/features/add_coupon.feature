Feature:Adding coupons to my order
  As a shopper, I want to be able to add coupons to my order
  so I can save money on my purchase

  Scenario:Add a coupon at check out
    Given I am on the checkout page
    And I have a 20% coupon
    When I add the 20% coupon to my order
    Then my order total should be reduced by 20%

  Scenario: Add multiple coupons at check out
    Given I am on the checkout page
    And I have an item that costs $20.00
    And an item that costs $15.00
    When I add a coupon for 15% for the first item
    And a coupon for 25% for the second item
    Then my order total should be 6.75

  Scenario: Add an expired coupon
    Given I am on the checkout page
    When I submit an invalid coupon for my order
    Then I get an error message that my coupon is invalid
    And my order total is not updated