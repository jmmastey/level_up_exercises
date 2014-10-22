Feature: Shipping Estimation
  In order to find out the total cost of the product order
  As a consumer
  I would like to see the shipping estimator for the products in my cart

  Background:
    Given I have an empty shopping cart
    And "Product 1" costs $5.00
    And "Product 2" costs $20.00
    And "Product 3" costs $29.99
    And "Product 1" shipping costs $1.00 each
    And "Product 2" shipping costs $5.00 total
    And "Product 3" shipping costs $7.50 each
    And I am on the shopping cart page

  Scenario Outline: Shipping calculator
    When I add <quantity> "<product>" to the shopping cart
    When I fill in "Postal Code" with "<postal_code>"
    And I press "Estimate Shipping"
    Then I should see shipping cost be $<estimated_shipping_cost>
    And I should see message "<info>"

  @happy_path
  Examples: Happy Path
    | quantity | product   | postal_code | estimated_shipping_cost | info |
    | 1        | Product 1 | 60654       | 1.00                    |      |
    | 2        | Product 2 | 60654       | 5.00                    |      |
    | 3        | Product 3 | 60654       | 22.50                   |      |

  @sad_path
  Examples: Sad Path
    | quantity | product   | postal_code | estimated_shipping_cost | info                          |
    | 1        | Product Z | 60606       | N/A                     | Cannot calculate shipping now |

  @bad_path
  Examples: Bad Path
    | quantity | product   | postal_code | estimated_shipping_cost | info                |
    | 1        | Product 1 | 1234        | N/A                     | Invalid Postal Code |
    | 1        | Product 1 | 123456      | N/A                     | Invalid Postal Code |
    | 1        | Product 1 | *           | N/A                     | Invalid Postal Code |
    | 1        | Product 1 | heaven      | N/A                     | Invalid Postal Code |
    | 1        | Product 1 | hell        | N/A                     | Invalid Postal Code |
    | 1        | Product 1 | canada      | N/A                     | Invalid Postal Code |

  @happy_path
  Scenario: Estimate shipping with mixed types
    When I add 2 "Product 1" to shopping cart
    And I add 2 "Product 2" to shopping cart
    And I add 1 "Product 3" to shopping cart
    And I fill in "Postal Code" with "60654"
    And I press "Estimate Shipping"
    Then I should see shipping cost be 14.50

  @sad_path
  Scenario: Estimate shipping with mixed type and no shipping defined
    When I add 1 "Product 1" to the shopping cart
    And I add 1 "Product Z" to the shopping cart
    And I fill in "Postal Code" with "60613"
    And I press "Estimate Shipping"
    Then I should see shipping cost be N/A
    And I should see "Cannot calculate shipping now"

  @bad_path
  Scenario: Estimate shipping with non-existing products
    When I add 1 "Product 1" to the shopping cart
    And I add 1 "Product Z" to the shopping cart
    And I fill in "Postal Code" with "60613"
    And I press "Estimate Shipping"
    Then I should see google home page