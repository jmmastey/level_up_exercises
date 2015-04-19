Feature: Coupon Codes
  In order to get discount
  As a online customer
  I want to add coupon codes

  Background:
    Given I have an item in the cart

#Happy Path
  Scenario: valid coupon code 
    When I give valid coupon code
    Then I should see the coupon applied to my cart 
    And Total cost should be reduced based on the coupon

#Sad Path
  Scenario: expired coupon code
    When I give expired coupon code
    Then I should see an error that the coupon is expired
    And Total cost does not change

#Bad Path
  Scenario: invalid coupon code
    When I give invalid coupon code
    Then I should see an error that the coupon code is invalid
    And Total cost does not change