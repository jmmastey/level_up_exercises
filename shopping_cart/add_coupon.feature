Feature: Add coupons to the shopping cart
  As an online customer
  I should be able to add coupons to the cart
  So that I can get discounts before checkout

Background:
  Given that I have 1 quantity of "item_A" in the cart
  And the total checkout amount is "$10.00" on the cart

Scenario Outline: Add coupon to receive discount
  When I add coupon "<coupon>" to the cart
  Then I should see the cart shows total amount "<final_price>"
  And I should see the "<message>"

@happy
Examples:
|   coupon   |   final_price   |                message                 |
|  TAKE30OFF |     $7.00       | Coupon applied and discount provided   |
|  FIFTYOFF  |     $5.00       | Coupon applied and discount provided   |

@bad
Examples:
|   coupon   |   final_price   |                message                         |
|  100OFF    |     $10.00      | Invalid coupon applied, no discount provided   |
|  NOV50     |     $10.00      | Expired coupon applied, no discount provided   |

@sad
Examples:
|   coupon   |   final_price   |                message                    |
|            |     $10.00      | No coupon applied, no discount provided   |
