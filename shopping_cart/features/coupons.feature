Feature: Applying coupons

  Scenario Outline: Customer has a valid coupon
    Given the cart has "item_1" with price <total_price>
    When the customer applies a <coupon> of worth <coupon_price>
    Then the customer should see message <message>
    And the total price should be <final_price>

    Examples:
      | coupon         | total_price |     message                  | coupon_price | final_price |
      | valid coupon   |  100        | coupon has been applied      | 10           |   90        |
      | invalid coupon |  100        | coupon has not been applied  | 10           |   100       |
