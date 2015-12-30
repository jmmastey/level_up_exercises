Feature: Subtotal Feature
  As a customer
  I want to be able to put in my address information
  And input any coupons
  So that I can get proper subtotals

  Scenario: See subtotal of items in shopping cart
    Given I have items in my shopping cart
    When I want to see the subtotal of my purchase
    Then I should be directed to the subtotal page

  Scenario: Input address information
    Given I am on the subtotal page
    When I input my address information
    Then I should be able to see shipping estimates
    And the subtotal should be updated

  Scenario: Input coupons
    Given I am on the subtotal page
    When I add a coupon code
    Then I should be able to see the coupon added
    And the subtotal should be updated
