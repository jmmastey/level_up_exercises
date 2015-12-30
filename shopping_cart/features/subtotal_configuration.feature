Feature: Subtotal Configuration Feature
  As a customer
  I want to be able to put in my address information
  And input any coupons
  So that I can get proper subtotals

  Scenario: There are no items to see a subtotal of shopping cart
    Given I have no items in my shopping cart
    When I want to see the subtotal of my purchase
    Then I should see the error message

  Scenario: Invalid address information
    Given I am on the subtotal page
    When I input invalid address information
    Then I should see the error message

  Scenario: Expired or non-existent coupon
    Given I am on the subtotal page
    When I add an expired or non-exitent coupon code
    Then I should see the error message
