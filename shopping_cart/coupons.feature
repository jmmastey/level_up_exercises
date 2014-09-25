Feature: Adding coupons
  In order to purchase items online
  As an online shopper
  I want to be able to apply coupons to my order

  Background: My cart already contains some items
    Given my cart contains 3 pairs of socks
    And my cart contains 1 pair of jeans
    And I'm on the shopping cart page

  Scenario: Valid coupon
    When I enter "winter-promo2014" into the "coupon" field
    And I click "Add Coupon"
    Then I should see a discount on my total order price

  Scenario: Expired coupon
    When I enter "summer-promo2014" into the "coupon" field
    And I click "Add Coupon"
    Then I should see the message "This coupon has expired"

  Scenario: Invalid coupon
    When I enter "something-invalid" into the "coupon" field
    And I click "Add Coupon"
    Then I should see the message "This coupon is invalid"