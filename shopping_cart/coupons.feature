Feature: Coupon Codes
  In order to save money on my purchase
  As a shopper
  I would like to be able to add valid coupon codes to the shopping cart

  Background:
    Given the shopping cart is empty
    And "Widget A" costs $1.00
    And "Widget B" costs $10.00
    And "Widget C" costs $100.00
    And coupon for "10%" off with code "CPN1"
    And coupon for "$10" off $50 with code "CPN2"
    And coupon for "$10" off "Widget C" with code "CPN3"
    And expired coupon for "10%" off with code "CPN4"
    And I am viewing the shopping cart

  Scenario Outline: Using coupons
    When I add <qty> "<item>" to the shopping cart
    And I fill in "Coupon Code" with "<coupon>"
    And I press "Apply Coupon"
    Then I should see discount of $<discount>
    And I should see subtotal price $<subtotal>
    And I should see <message>

    @happy_path
    Examples:
      | qty | item     | coupon | discount | subtotal | message |
      | 1   | Widget A | CPN1   | 0.10     | 0.90     |         |
      | 2   | Widget A | CPN1   | 0.20     | 1.80     |         |
      | 10  | Widget A | CPN1   | 1.00     | 9.00     |         |
      | 50  | Widget A | CPN1   | 5.00     | 45.00    |         |
      | 50  | Widget A | CPN2   | 10.00    | 40.00    |         |
      | 1   | Widget B | CPN1   | 1.00     | 9.00     |         |
      | 5   | Widget B | CPN2   | 10.00    | 40.00    |         |
      | 1   | Widget C | CPN1   | 10.00    | 90.00    |         |
      | 2   | Widget C | CPN1   | 20.00    | 180.00   |         |
      | 1   | Widget C | CPN2   | 10.00    | 90.00    |         |
      | 2   | Widget C | CPN2   | 10.00    | 190.00   |         |
      | 1   | Widget C | CPN3   | 10.00    | 90.00    |         |
      | 2   | Widget C | CPN3   | 20.00    | 180.00   |         |

    @sad_path
    Examples:
      | qty | item     | coupon | discount | subtotal | message                                |
      | 1   | Widget A | CPN2   | 0.00     | 1.00     | Minimum $50 order required for coupon  |
      | 1   | Widget B | CPN2   | 0.00     | 10.00    | Minimum $50 order required for coupon  |
      | 1   | Widget A | CPN3   | 0.00     | 1.00     | Coupon does not apply to items in cart |
      | 1   | Widget A | CPN4   | 0.00     | 1.00     | Coupon is expired                      |
      | 1   | Widget A |        | 0.00     | 1.00     | Please Enter a Coupon Code             |

    @bad_path
    Examples:
      | qty | item     | coupon   | discount | subtotal | message                    |
      | 1   | Widget A | 1234     | 0.00     | 1.00     | Invalid Coupon Code        |
      | 1   | Widget A | ABCD     | 0.00     | 1.00     | Invalid Coupon Code        |
      | 1   | Widget A | cpn1     | 0.00     | 1.00     | Invalid Coupon Code        |
      | 1   | Widget A | CPN1A    | 0.00     | 1.00     | Invalid Coupon Code        |
      | 1   | Widget A | CPN1 123 | 0.00     | 1.00     | Invalid Coupon Code        |
      | 1   | Widget A | A        | 0.00     | 1.00     | Invalid Coupon Code        |

  @sad_path
  Scenario: Two valid coupon codes
    And I add 1 "Widget C" to the shopping cart
    And I fill in "Coupon Code" with "CPN1"
    And I press "Apply Coupon"
    And I fill in "Coupon Code" with "CPN2"
    And I press "Apply Coupon"
    Then I should see "Cannot combine coupons"

  @happy_path
  Scenario: Product specific coupon with two products in cart
    When I add 1 "Widget A" to the shopping cart
    And I add 1 "Widget C" to the shopping cart
    And I fill in "Coupon Code" with "CPN3"
    And I press "Apply Coupon"
    Then I should see a discount of $10.00
    And I should see subtotal price $91.00
