Feature: Coupons
  In order to get a discount
  As a customer
  I want to use coupon codes

  Scenario: I submit a valid coupon code
    Given an order that costs $350
    When I submit a valid code for "$10 off any order"
    Then the order costs $340
    And the code is used

  Scenario: I submit two valid coupon codes
    Given an order that costs $350
    When I submit 2 valid codes for "$10 off any order"
    Then the order costs $330
    
  # Cucumber is not the right tool for this test
  Scenario: Processing a code takes less than 1 second at least 95% of the time

  # Cucumber is not the right tool for this test
  Scenario: My credentials are handled securely

  Scenario: I submit an expired coupon code
    Given an order that costs $350
    When I submit an expired code for "$10 off any order"
    Then the order costs $350

  Scenario: I submit an invalid coupon code
    Given an order that costs $350
    When I submit an invalid code
    Then the order costs $350

  Scenario: I submit a coupon that is not relevant to this order
    Given an order that costs $350 with 0 items with SKU 9
    When I submit a valid code for "$10 off SKU 9"
    Then the order costs $350
    And the code is not used
    
  Scenario: I submit a coupon code that has already been used
    Given an order that costs $350
    When I submit a used code for "$10 off any order"
    Then the order costs $350
    And the code is used