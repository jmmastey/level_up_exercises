Feature: Shipping Information
  In order to find out the total cost of the order
  As a shopper
  I would like to see the shipping cost for the products in my cart

  Background:
    Given I have an empty shopping cart
    And "Widget A" costs $1.00
    And "Widget B" costs $10.00
    And "Widget C" costs $100.00
    And "Widget A" shipping costs $1.00 each
    And "Widget B" shipping costs $10.00 total
    And "Widget C" shipping costs $2.00 per pound
    And "Widget C" weights 10 lbs
    And I am viewing the shopping cart

  Scenario Outline: Calculating shipping
    When I add <quantity> "<item>" to the shopping cart
    When I fill in "Zip Code" with "<zip_code>"
    And I press "Calculate Shipping"
    Then I should see shipping cost be $<shipping_cost>
    And I should see message "<message>"

    @happy_path
    Examples: Happy Path
      | quantity | item     | zip_code   | shipping_cost | message |
      | 1        | Widget A | 60606      | 1.00          |         |
      | 1        | Widget A | 60606-1234 | 1.00          |         |
      | 1        | Widget A | 606061234  | 1.00          |         |
      | 2        | Widget A | 60606      | 2.00          |         |
      | 10       | Widget A | 60606      | 10.00         |         |
      | 100      | Widget A | 60606      | 100.00        |         |
      | 1        | Widget B | 60606      | 10.00         |         |
      | 10       | Widget B | 60606      | 10.00         |         |
      | 100      | Widget B | 60606      | 10.00         |         |
      | 1        | Widget C | 60606      | 20.00         |         |
      | 2        | Widget C | 60606      | 40.00         |         |

    @sad_path
    Examples: Sad Path
      | quantity | item     | zip_code | shipping_cost | message                       |
      | 1        | Widget D | 60606    | N/A           | Cannot calculate shipping now |

    @bad_path
    Examples: Bad Path
      | quantity | item     | zip_code | shipping_cost | message          |
      | 1        | Widget A | 1234     | N/A           | Invalid Zip Code |
      | 1        | Widget A | 123456   | N/A           | Invalid Zip Code |
      | 1        | Widget A | a        | N/A           | Invalid Zip Code |
      | 1        | Widget A | abcde    | N/A           | Invalid Zip Code |
      | 1        | Widget A | abcdef   | N/A           | Invalid Zip Code |
      | 1        | Widget A | 60606f   | N/A           | Invalid Zip Code |

  @happy_path
  Scenario: Calculate shipping with mixed types
    When I add 2 "Widget A" to the shopping cart
    And I add 2 "Widget B" to the shopping cart
    And I add 1 "Widget C" to the shopping cart
    And I fill in "Zip Code" with "60606"
    And I press "Calculate Shipping"
    Then I should see shipping cost be $32.00

  @sad_path
  Scenario: Calculate shipping with mixed type and no shipping defined
    When I add 1 "Widget A" to the shopping cart
    And I add 1 "Widget D" to the shopping cart
    And I fill in "Zip Code" with "60606"
    And I press "Calculate Shipping"
    Then I should see shipping cost be N/A
    And I should see "Cannot calculate shipping now"
