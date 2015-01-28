Feature: Use Coupons
  In order to save money
  As a customer
  I want to use a coupon on my order

  Background:
    Given I am logged in
    And some coupons are valid
    And I am on the order total page
    And I have a positive order total

  @happy
  Scenario: Valid coupon entered
    When I enter a valid coupon code
    Then I see a coupon successfully applied message
    And my order total decreases by the right amount

  @sad
  Scenario: Invalid coupon entered
    When I enter an invalid coupon code
    Then I see a coupon does not exist message
    And my order total remains the same