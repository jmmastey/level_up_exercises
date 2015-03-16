Feature: apply to coupon to shopping cart

  Background:
    Given I have 2 "ipad" in shopping cart and they cost $800
    And I have  "iphone" in shopping cart and it cost $300
    And the total for these items are $1100

  Scenario Outline:
    Given I have <quantity> <product> to shopping cart
    When I applied <coupon_code>
    And I press "Apply coupon"
    Then I see a discount amount $<discount>
    And see a total of $<total>

  @happy
  Examples:
    | product      | quantity | coupon_code   | discount  | total   |
    | ipad         | 2        | 50OFF         | 100.00    | 700.00  |
    | iphone       | 1        | 10OFF         | 10.00     | 290.00  |

  @bad
  Examples:
    | product      | quantity | coupon_code  | discount | total     |
    | ipad         | 2        | test         | 0.00     | 800.00    |
    | iphone       | 1        | xvz          | 0.00     | 300.00    |

  @happy
    Scenario: Active coupon
    When I applied coupon code "50OFF"
    And press "Apply coupon"
    Then I see discount "100"
    And total "700"

  @bad
  Scenario: Expired coupon
    When I add 1 of "iphone" to shopping cart
    And I fill in "coupon" with "xvz"
    And I press "Apply Coupon"
    Then I should see "This is invalid coupon."