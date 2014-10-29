Feature: Shipping Estimate
  Customer should be able to obtain a shipping estimate for products in
  the shopping cart.

  Background:
    Given I have a empty shopping cart
    And "Item 1" which costs $10.00
    And "Item 2" which costs $20.00
    And "Item 3" which costs $50.00
    And "Item 1" shipping costs $2.00 each
    And "Item 2" shipping costs $4.00 each
    And "Item 3" shipping costs $6.00 each
    And I am on the shopping cart page

  Scenario Outline: Shipping Calculator
    When I add <quantity> of "<item>" to shopping cart
    When I set "Zip Code" with "<zipcode>"
    And I press "Shipping Estimate"
    Then I should see shipping cost to be "<estimated_ship_cost>"
    And I should see message "<info>"

  @happy_path
  Examples: Calculated shipping costs on valid in stock products
    | quantity | item   | zipcode    | estimated_ship_cost | info |
    | 1        | Item 1 | 60506      | $2.00               |      |
    | 1        | Item 2 | 60506      | $4.00               |      |
    | 1        | Item 3 | 60506      | $6.00               |      |
    | 1        | Item 3 | 60506-2242 | $6.00               |      |

  @sad_path
  Examples: Calculate shipping on a product that's not available to ship
    | quantity | item     | zipcode | estimated_ship_cost | info                        |
    | 1        | Item 999 | 60506   | Unavailable         | Shipping cost not available |

  @bad_path
  Examples: Calculate shipping costs with bad zip codes
    | quantity | item   | zipcode        | estimated_ship_cost | info             |
    | 1        | Item 1 | 99999          | Unavailable         | Invalid Zip Code |
    | 1        | Item 1 | 999            | Unavailable         | Invalid Zip Code |
    | 1        | Item 1 | 60506-223      | Unavailable         | Invalid Zip Code |
    | 1        | Item 1 | ZZZZZ          | Unavailable         | Invalid Zip Code |
    | 1        | Item 1 | 606060606      | Unavailable         | Invalid Zip Code |
    | 1        | Item 1 | 60506-22656565 | Unavailable         | Invalid Zip Code |

  @happy_path
  Scenario: Calculate shipping costs for multiple items
    When I add 2 of "Item 1" to shopping cart
    And I add 1 of "Item 2" to shopping cart
    When I set "Zip Code" with "60606"
    And I press "Shipping Estimate"
    Then I should see shipping cost to be "$8.00"
